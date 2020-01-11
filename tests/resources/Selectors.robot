*** Variables ***
${XP LAUNCH SECTION}    xpath://h2[contains(@class, 'jp-Launcher-sectionTitle')][text() = 'Starters']
${CSS LAUNCH CARD}    css:[data-category\="Starters"]
${CSS LAUNCH CARD TUTORIAL}    ${CSS LAUNCH CARD}\[title\="Tutorial for Robot Framework on Jupyter"]
${CSS LAUNCH CARD EXAMPLES}    ${CSS LAUNCH CARD}\[title\="More Robot Kernel Examples"]
${XP FILE TREE ITEM}    xpath://span[contains(@class, 'jp-DirListing-itemText')]
${XP FILE TREE TUTORIAL}    ${XP FILE TREE ITEM}\[text() = 'tutorial']
${XP FILE TREE TUTORIAL 00}    ${XP FILE TREE ITEM}\[text() = '00 Keyboard Shortcuts.ipynb']
${XP FILE TREE EXAMPLE}    ${XP FILE TREE ITEM}\[text() = 'robotkernel-examples']
${XP FILE TREE EXAMPLE OPENCV}    ${XP FILE TREE ITEM}\[text() = 'OpenCV.ipynb']
${CSS NOTEBOOK SAVE}    css:[data-icon="save"]
${JP STATUS BAR}    id:jp-bottom-panel
${CRUMBS HOME}    css:.jp-BreadCrumbs-home
