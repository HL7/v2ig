// v2-classic-tabs.js
// Discovers hidden content divs injected by generate_message_pages.py and
// adds them as tabs in the Formal Views jQuery UI tab set (#tabs).
//
// Handles:
//   #v2-classic-content  → "Message Structure" tab (inserted before Statistics)
//   #v2-ack-content      → "ACK Choreography" tab (inserted after Message Structure)
//
// Also removes the "All" tab from the tab set.
//
// Target tab order:
//   Key Elements | Differential | Snapshot | Message Structure | ACK Choreography | Statistics/References
//
// This script runs AFTER tabs.js has initialized the jQuery UI tabs widget.
// It must be loaded after jQuery, jQuery UI, and tabs.js.

(function() {
  var tabsDiv = document.getElementById('tabs');
  if (!tabsDiv) return;

  var tabList = tabsDiv.querySelector('ul');
  if (!tabList) return;

  // Inject CSS for classic notation styling
  if (document.getElementById('v2-classic-content')) {
    var style = document.createElement('style');
    style.textContent =
      '.v2-classic-notation { font-family: "Courier New", Courier, monospace; white-space: nowrap; }' +
      'tr.v2-classic-group { background-color: #f0f0f0; }';
    document.head.appendChild(style);
  }

  // Remove the "All" tab and its panel
  var allPanel = document.getElementById('tabs-all');
  if (allPanel) allPanel.parentNode.removeChild(allPanel);
  var allLinks = tabList.querySelectorAll('a[href="#tabs-all"]');
  for (var i = 0; i < allLinks.length; i++) {
    var li = allLinks[i].parentNode;
    li.parentNode.removeChild(li);
  }

  // Find the Statistics/References tab list item and panel for insertion point
  var summLi = null;
  var links = tabList.querySelectorAll('a[href="#tabs-summ"]');
  if (links.length > 0) {
    summLi = links[0].parentNode;
  }

  // Helper: insert a hidden-div's content as a tab before Statistics/References
  // Falls back to appending at end if Statistics tab not found
  function addTab(sourceId, tabId, tabLabel) {
    var sourceDiv = document.getElementById(sourceId);
    if (!sourceDiv) return;

    // Create the tab panel — insert before the Statistics panel
    var panel = document.createElement('div');
    panel.id = tabId;
    panel.innerHTML = sourceDiv.innerHTML;

    var summPanel = document.getElementById('tabs-summ');
    if (summPanel) {
      tabsDiv.insertBefore(panel, summPanel);
    } else {
      tabsDiv.appendChild(panel);
    }

    // Add the tab list item before Statistics
    var li = document.createElement('li');
    li.innerHTML = '<a href="#' + tabId + '">' + tabLabel + '</a>';
    if (summLi) {
      tabList.insertBefore(li, summLi);
    } else {
      tabList.appendChild(li);
    }

    // Remove the hidden source div
    sourceDiv.parentNode.removeChild(sourceDiv);
  }

  // Add tabs in order: Message Structure, then ACK Choreography
  addTab('v2-classic-content', 'tabs-classic', 'Message Structure');
  addTab('v2-ack-content', 'tabs-ack', 'ACK Choreography');

  // Refresh the jQuery UI tabs widget to pick up changes
  try {
    $('#tabs').tabs('refresh');
  } catch(e) {
    // If tabs widget isn't initialized yet, this is a no-op
  }
})();
