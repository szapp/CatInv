# Categorized Inventory

[![Scripts](https://github.com/szapp/CatInv/actions/workflows/scripts.yml/badge.svg)](https://github.com/szapp/CatInv/actions/workflows/scripts.yml)
[![Validation](https://github.com/szapp/CatInv/actions/workflows/validation.yml/badge.svg)](https://github.com/szapp/CatInv/actions/workflows/validation.yml)
[![Build](https://github.com/szapp/CatInv/actions/workflows/build.yml/badge.svg)](https://github.com/szapp/CatInv/actions/workflows/build.yml)
[![GitHub release](https://img.shields.io/github/v/release/szapp/CatInv.svg)](https://github.com/szapp/CatInv/releases/latest)

Categorized inventory for Gothic 2 and Gothic 2 NotR. This patch extends the inventory by browsable categories.

This is a modular modification (a.k.a. patch or add-on) that can be installed and uninstalled at any time and is virtually compatible with any modification.
It supports <kbd>Gothic II (Classic)</kbd> and <kbd>Gothic II: NotR</kbd>.

<sup>Generated from [szapp/patch-template](https://github.com/szapp/patch-template).</sup>

<div align="center">
<img src="https://github.com/szapp/CatInv/assets/20203034/b4bb1dba-8b11-4167-b686-d5edfe9206dc" alt="Screenshot" width="18%" /> &nbsp;  
<img src="https://github.com/szapp/CatInv/assets/20203034/484258bc-e5e6-407b-8a3d-117bbe8ef7dc" alt="Screenshot" width="24%" /> &nbsp;
<img src="https://github.com/szapp/CatInv/assets/20203034/ecaf9413-fffe-4970-8eb3-b9bbe305d528" alt="Screenshot" width="24%" /> &nbsp;
<img src="https://github.com/szapp/CatInv/assets/20203034/af3a2430-90f9-47a3-8fe3-9c032d872857" alt="Screenshot" width="24%" />
</div>

## Additional keys bindings

<table>
  <tbody>
    <tr>
      <td><kbd>SHIFT</kbd> + <kbd>left</kbd>/<kbd>right</kbd></td>
      <td>Switch between categories</td>
    </tr>
    <tr>
      <td><kbd>Choose Weapon</kbd></td>
      <td>Quick-switch between player and container/trading inventory</td>
    </tr>
    <tr>
      <td><kbd>HOME</kbd></td>
      <td>Quick-jump to first item</td>
    </tr>
    <tr>
      <td><kbd>END</kbd></td>
      <td>Quick-jump to last item</td>
    </tr>
    <tr>
      <td><kbd>SHIFT</kbd> + <kbd>HOME</kbd></td>
      <td>Quick-switch to first category</td>
    </tr>
    <tr>
      <td><kbd>SHIFT</kbd> + <kbd>END</kbd></td>
      <td>Quick-switch to last category</td>
    </tr>
  </tbody>
</table>

## INI settings

The categorized inventory can be adjusted with three settings in the Gothic.ini in the section `[GAME]`.

1. The categories and their order can be set with `invCatOrder`.
2. The setting `invCatChangeOnLast` (0 or 1) changes whether navigation beyond the last/first column should switch the category instead of moving the selection to the previous/next line.
3. With `invCatG1Mode` (0 or 1) the 'all' category is removed and all non-player inventories do not have categories.

## Notes

Patch includes CatInv.

CatInv, Copyright (C) 2019-2024  Sören Zapp.  
Released under the MIT License.  
Full license in Ninja\CatInv\Content\CatInv\LICENSE

## Installation

1. Download the latest release of `CatInv.vdf` from the [releases page](https://github.com/szapp/CatInv/releases/latest).

2. Copy the file `CatInv.vdf` to `[Gothic]\Data\`. To uninstall, remove the file again.

The patch is also available on
- [World of Gothic](https://www.worldofgothic.de/dl/download_617.htm) | [Forum thread](https://forum.worldofplayers.de/forum/threads/1546962)
- [Spine Mod-Manager](https://clockwork-origins.com/spine/)
- [Steam Workshop Gothic 2](https://steamcommunity.com/sharedfiles/filedetails/?id=2787221263)

### Requirements

<table><thead><tr><th>Gothic II (Classic)</th><th>Gothic II: NotR</th></tr></thead>
<tbody><tr><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 1.30.0.0</a></td><td><a href="https://www.worldofgothic.de/dl/download_278.htm">Report version 2.6.0.0</a></td></tr></tbody>
<tbody><tr><td colspan="2" align="center"><a href="https://github.com/szapp/Ninja">Ninja 2.8</a> or higher</td></tr></tbody></table>

<!--

If you are interested in writing your own patch, please do not copy this patch!
Instead refer to the PATCH TEMPLATE to build a foundation that is customized to your needs!
The patch template can found at https://github.com/szapp/patch-template.

-->
