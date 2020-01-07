*** Variables ***
${XP LAUNCH SECTION}    xpath://h2[contains(@class, 'jp-Launcher-sectionTitle')][contains(text(), 'Starters')]
${CSS LAUNCH CARD}    css:[data-category\="Starters"]
${CSS LAUNCH CARD TUTORIAL}    ${CSS LAUNCH CARD}\[title\="Tutorial for Robot Framework on Jupyter"]
${XP FILE TREE ITEM}    xpath://span[contains(@class, 'jp-DirListing-itemText')]
${XP FILE TREE TUTORIAL}    ${XP FILE TREE ITEM}\[contains(text(), 'robotkernel-tutorial')]
${XP FILE TREE TUTORIAL 00}    ${XP FILE TREE ITEM}\[contains(text(), '00 Keyboard Shortcuts.ipynb')]
${CSS NOTEBOOK SAVE}    css:[data-icon="save"]
${JP STATUS BAR}    id:jp-bottom-panel
${CRUMBS HOME}    css:.jp-BreadCrumbs-home
