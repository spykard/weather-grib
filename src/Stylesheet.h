/**********************************************************************
Weathergrib: meteorological GRIB file viewer
Created by David Gal

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
***********************************************************************/
#ifndef STYLESHEET_H
#define STYLESHEET_H

QString styleSheetDef =
        "QStatusBar,QScrollBar,QDialog,QMainWindow, QFrame {color: #ffffff; background: #013a55}"
        "QPushButton {background-color: #013a55; border-style: outset; border-width: 2px;"
                    "border-color: #777777; padding: 6px;min-width: 6em; color: #ffffff;}"
        "QPushButton:pressed {border-width: 2px; border-style: inset;}"
        "QPushButton:disabled {color: #aaaaaa;}"
        "QProgressBar{border: 2px solid grey; border-radius: 5px; text-align: center;}"
        "QProgressBar::chunk{background-color: #ff6600; width: 10px; margin: 0.5px;}"
        "QCheckBox, QRadioButton{color: #ffffff; background-color: #013a55}"
        "QCheckBox:disabled{color: #aaaaaa;}"
        "QToolBar {background: #013a55;}"
        "QToolBar::separator{width: 2px; background: #aaaaaa;}"
        "QTabBar::tab {background: #013a55; color: #ffffff;}"
        "QTabBar::tab:selected {background: #ffffff; color: #013a55; }"
        "QTabBar::tab:hover {background: #aaaaaa; color: #013a55; }"
        "QDockWidget {color: #ffffff;}"
        ;

QString menuStyleSheetDef =
        "QMenu,QMenuBar {color: #ffffff; background: #013a55;}"
        "QMenuBar::item:selected, QMenu::item::selected {color: #013a55; background-color: #dddddd;}"
        "QMenu::item:disabled {color: #aaaaaa;}"
        ;



#endif // STYLESHEET_H
