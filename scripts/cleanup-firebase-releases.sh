#!/bin/bash
# Cleanup old Firebase Hosting releases, keeping only the last N (default: 2)
# Shows storage consumed and freed

SITE_ID="stratminds-ai-bot"
PROJECT_ID="stratminds-ai-bot"
KEEP_COUNT="${1:-2}"

# Get access token
TOKEN=$(gcloud auth print-access-token 2>/dev/null)
if [ -z "$TOKEN" ]; then
  echo "Error: Could not get access token. Run 'gcloud auth login' first."
  exit 1
fi

API_BASE="https://firebasehosting.googleapis.com/v1beta1"

# Common headers
AUTH_HEADER="Authorization: Bearer $TOKEN"
QUOTA_HEADER="x-goog-user-project: $PROJECT_ID"

# List all versions
echo "Fetching releases for site: $SITE_ID"
VERSIONS_JSON=$(curl -s -H "$AUTH_HEADER" -H "$QUOTA_HEADER" \
  "$API_BASE/sites/$SITE_ID/versions?pageSize=100")

# Helper to format bytes
format_bytes() {
  local bytes=$1
  if [ "$bytes" -ge 1073741824 ]; then
    echo "$(echo "scale=2; $bytes / 1073741824" | bc) GB"
  elif [ "$bytes" -ge 1048576 ]; then
    echo "$(echo "scale=2; $bytes / 1048576" | bc) MB"
  elif [ "$bytes" -ge 1024 ]; then
    echo "$(echo "scale=2; $bytes / 1024" | bc) KB"
  else
    echo "$bytes bytes"
  fi
}

# Check for errors
if echo "$VERSIONS_JSON" | jq -e '.error' >/dev/null 2>&1; then
  echo "Error fetching versions:"
  echo "$VERSIONS_JSON" | jq -r '.error.message' 2>/dev/null
  exit 1
fi

# Extract version info with file sizes (only FINALIZED versions)
VERSIONS_DATA=$(echo "$VERSIONS_JSON" | jq -r '.versions | map(select(.status == "FINALIZED")) | sort_by(.createTime) | reverse | .[] | "\(.name)|\(.fileCount // 0)|\(.versionBytes // 0)"' 2>/dev/null)

if [ -z "$VERSIONS_DATA" ]; then
  echo "No versions found."
  exit 0
fi

# Count and calculate totals
TOTAL=$(echo "$VERSIONS_DATA" | wc -l | tr -d ' ')
TOTAL_BYTES=$(echo "$VERSIONS_JSON" | jq '[.versions | map(select(.status == "FINALIZED")) | .[].versionBytes // 0 | tonumber] | add' 2>/dev/null)

echo "Found $TOTAL releases. Total storage: $(format_bytes ${TOTAL_BYTES:-0})"
echo "Keeping last $KEEP_COUNT."
echo ""

if [ "$TOTAL" -le "$KEEP_COUNT" ]; then
  echo "Nothing to delete."
  exit 0
fi

# Calculate storage to keep vs delete
KEEP_BYTES=$(echo "$VERSIONS_JSON" | jq "[.versions | map(select(.status == \"FINALIZED\")) | sort_by(.createTime) | reverse | .[:$KEEP_COUNT][].versionBytes // 0 | tonumber] | add" 2>/dev/null)
DELETE_BYTES=$((${TOTAL_BYTES:-0} - ${KEEP_BYTES:-0}))

# Skip first KEEP_COUNT, delete the rest
TO_DELETE=$(echo "$VERSIONS_DATA" | tail -n +$((KEEP_COUNT + 1)))
DELETE_COUNT=$(echo "$TO_DELETE" | wc -l | tr -d ' ')

echo "Storage to free: $(format_bytes $DELETE_BYTES)"
echo "Deleting $DELETE_COUNT old releases..."
echo ""

FREED_BYTES=0
for LINE in $TO_DELETE; do
  VERSION=$(echo "$LINE" | cut -d'|' -f1)
  VERSION_BYTES=$(echo "$LINE" | cut -d'|' -f3)
  VERSION_ID=$(basename "$VERSION")

  echo -n "Deleting $VERSION_ID ($(format_bytes ${VERSION_BYTES:-0}))... "

  RESPONSE=$(curl -s -X DELETE -H "$AUTH_HEADER" -H "$QUOTA_HEADER" \
    "$API_BASE/$VERSION")

  # Check if successful (empty response or no error)
  if echo "$RESPONSE" | jq -e '.error' >/dev/null 2>&1; then
    echo "FAILED"
    echo "$RESPONSE" | jq -r '.error.message' 2>/dev/null
  else
    echo "OK"
    FREED_BYTES=$((FREED_BYTES + ${VERSION_BYTES:-0}))
  fi
done

echo ""
echo "Cleanup complete."
echo "Storage freed: $(format_bytes $FREED_BYTES)"
echo "Remaining storage: $(format_bytes $((${TOTAL_BYTES:-0} - FREED_BYTES)))"
