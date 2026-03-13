// v2-classic-tabs.js
// Discovers hidden content divs injected by page generators and
// adds them as tabs in the Formal Views jQuery UI tab set (#tabs).
//
// Handles:
//   #v2-ack-content      → "ACK Choreography" tab (inserted before Statistics)
//   #v2-segment-content  → "HL7 Attribute Table" tab (inserted before Statistics)
//
// Also removes the "All" tab and "Key Elements" tab from the tab set.
//
// Target tab order (message pages):
//   Differential | Snapshot | ACK Choreography | Statistics/References
//
// Target tab order (segment pages):
//   Differential | Snapshot | HL7 Attribute Table | Statistics/References
//
// This script runs AFTER tabs.js has initialized the jQuery UI tabs widget.
// It must be loaded after jQuery, jQuery UI, and tabs.js.

(function() {
  var tabsDiv = document.getElementById('tabs');
  if (!tabsDiv) return;

  var tabList = tabsDiv.querySelector('ul');
  if (!tabList) return;

  // Remove the "All" tab and its panel
  var allPanel = document.getElementById('tabs-all');
  if (allPanel) allPanel.parentNode.removeChild(allPanel);
  var allLinks = tabList.querySelectorAll('a[href="#tabs-all"]');
  for (var i = 0; i < allLinks.length; i++) {
    var li = allLinks[i].parentNode;
    li.parentNode.removeChild(li);
  }

  // Remove the "Key Elements" tab and its panel
  var kePanel = document.getElementById('tabs-key');
  if (kePanel) kePanel.parentNode.removeChild(kePanel);
  var keLinks = tabList.querySelectorAll('a[href="#tabs-key"]');
  for (var i = 0; i < keLinks.length; i++) {
    var li = keLinks[i].parentNode;
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

  // Add tabs in order: ACK Choreography, HL7 Attribute Table
  addTab('v2-ack-content', 'tabs-ack', 'ACK Choreography');
  addTab('v2-segment-content', 'tabs-segment-def', 'HL7 Attribute Table');

  // Refresh the jQuery UI tabs widget to pick up changes
  try {
    $('#tabs').tabs('refresh');
  } catch(e) {
    // If tabs widget isn't initialized yet, this is a no-op
  }
})();
