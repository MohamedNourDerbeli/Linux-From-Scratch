#!/usr/bin/python

from PyQt6 import QtCore, QtGui, QtWidgets
import re
import sys
from subprocess import *
from app.tools.tool import *
from PyQt6.QtCore import QProcess

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(920, 732)

        self.user_data = {
            "USERNAME": "",
            "PASSWORD": ""
        }
        self.dataFile = 'info.txt'
        self.mainEntry = ['app/src/dummy.sh']
        
        
        self.process = None
        self.max_pages = 4
        self.current_page_index = 0

        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        self.centralwidget.setObjectName("centralwidget")

        self.header_frame = QtWidgets.QFrame(parent=self.centralwidget)
        self.header_frame.setGeometry(QtCore.QRect(9, 9, 406, 46))
        self.header_frame.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.header_frame.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.header_frame.setObjectName("header_frame")

        self.horizontalLayout = QtWidgets.QHBoxLayout(self.header_frame)
        self.horizontalLayout.setObjectName("horizontalLayout")

        self.PrevButton = QtWidgets.QPushButton(parent=self.header_frame)
        self.PrevButton.clicked.connect(self.prevPage)
        self.PrevButton.setMinimumSize(QtCore.QSize(190, 0))
        self.PrevButton.setEnabled(False)
        self.PrevButton.setObjectName("PrevButton")

        self.horizontalLayout.addWidget(self.PrevButton)

        self.NextButton = QtWidgets.QPushButton(parent=self.header_frame)
        self.NextButton.setMinimumSize(QtCore.QSize(190, 0))
        self.NextButton.clicked.connect(self.nextPage)
        self.NextButton.setEnabled(True)
        self.NextButton.setObjectName("NextButton")

        self.horizontalLayout.addWidget(self.NextButton)

        self.main_body = QtWidgets.QFrame(parent=self.centralwidget)
        self.main_body.setGeometry(QtCore.QRect(9, 60, 901, 661))
        self.main_body.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.main_body.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.main_body.setObjectName("main_body")

        self.frame = QtWidgets.QFrame(parent=self.main_body)
        self.frame.setGeometry(QtCore.QRect(9, 10, 805, 95))
        self.frame.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame.setObjectName("frame")

        self.horizontalLayout_2 = QtWidgets.QHBoxLayout(self.frame)
        self.horizontalLayout_2.setObjectName("horizontalLayout_2")

        self.image_banner = QtWidgets.QLabel(parent=self.frame)
        self.image_banner.setText("")
        self.image_banner.setPixmap(QtGui.QPixmap("app/src/img/lfs-logo.png"))
        self.image_banner.setScaledContents(False)
        self.image_banner.setObjectName("image_banner")

        self.horizontalLayout_2.addWidget(self.image_banner)
        self.label = QtWidgets.QLabel(parent=self.frame)

        font = QtGui.QFont()
        font.setPointSize(25)

        self.label.setFont(font)
        self.label.setLayoutDirection(QtCore.Qt.LayoutDirection.LeftToRight)
        self.label.setAlignment(QtCore.Qt.AlignmentFlag.AlignCenter)
        self.label.setObjectName("label")

        self.horizontalLayout_2.addWidget(self.label)

        self.frame_3 = QtWidgets.QFrame(parent=self.main_body)
        self.frame_3.setGeometry(QtCore.QRect(10, 120, 881, 531))
        self.frame_3.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_3.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_3.setObjectName("frame_3")

        self.stackedWidget = QtWidgets.QStackedWidget(parent=self.frame_3)
        self.stackedWidget.setGeometry(QtCore.QRect(9, 9, 861, 408))
        self.stackedWidget.setObjectName("stackedWidget")

        self.page1 = QtWidgets.QWidget()
        self.page1.setObjectName("page1")

        self.verticalLayout = QtWidgets.QVBoxLayout(self.page1)
        self.verticalLayout.setObjectName("verticalLayout")

        self.textBrowser_2 = QtWidgets.QTextBrowser(parent=self.page1)
        self.textBrowser_2.setObjectName("textBrowser_2")

        self.verticalLayout.addWidget(self.textBrowser_2)

        self.textBrowser = QtWidgets.QTextBrowser(parent=self.page1)
        self.textBrowser.setObjectName("textBrowser")

        self.verticalLayout.addWidget(self.textBrowser)
        self.stackedWidget.addWidget(self.page1)

        self.page2 = QtWidgets.QWidget()
        self.page2.setObjectName("page2")

        self.frame_2 = QtWidgets.QFrame(parent=self.page2)
        self.frame_2.setGeometry(QtCore.QRect(50, 30, 281, 111))
        self.frame_2.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_2.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_2.setObjectName("frame_2")
        self.label_2 = QtWidgets.QLabel(parent=self.frame_2)
        self.label_2.setGeometry(QtCore.QRect(20, 20, 91, 20))
        self.label_2.setObjectName("label_2")

        self.lineEdit = QtWidgets.QLineEdit(parent=self.frame_2)
        self.lineEdit.setGeometry(QtCore.QRect(32, 70, 211, 26))
        self.lineEdit.setObjectName("lineEdit")        

        self.frame_4 = QtWidgets.QFrame(parent=self.page2)
        self.frame_4.setGeometry(QtCore.QRect(340, 30, 441, 111))
        self.frame_4.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_4.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_4.setObjectName("frame_4")

        self.label_3 = QtWidgets.QLabel(parent=self.frame_4)
        self.label_3.setGeometry(QtCore.QRect(20, 30, 141, 18))
        self.label_3.setObjectName("label_3")

        self.lineEdit_2 = QtWidgets.QLineEdit(parent=self.frame_4)
        self.lineEdit_2.setGeometry(QtCore.QRect(20, 70, 141, 26))
        self.lineEdit_2.setEchoMode(QtWidgets.QLineEdit.EchoMode.Password)
        self.lineEdit_2.setObjectName("lineEdit_2")

        


        self.label_8 = QtWidgets.QLabel(parent=self.frame_4)
        self.label_8.setGeometry(QtCore.QRect(240, 30, 141, 18))
        self.label_8.setObjectName("label_8")

        self.lineEdit_3 = QtWidgets.QLineEdit(parent=self.frame_4)
        self.lineEdit_3.setGeometry(QtCore.QRect(240, 70, 141, 26))
        self.lineEdit_3.setEchoMode(QtWidgets.QLineEdit.EchoMode.Password)
        self.lineEdit_3.setObjectName("lineEdit_3")

        self.frame_6 = QtWidgets.QFrame(parent=self.page2)
        self.frame_6.setGeometry(QtCore.QRect(50, 150, 731, 331))
        self.frame_6.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_6.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_6.setObjectName("frame_6")

        self.label_7 = QtWidgets.QLabel(parent=self.frame_6)
        self.label_7.setGeometry(QtCore.QRect(40, 30, 141, 18))
        self.label_7.setObjectName("label_7")

        self.label_9 = QtWidgets.QLabel(parent=self.frame_6)
        self.label_9.setGeometry(QtCore.QRect(50,150,731,331))
        
        self.stackedWidget.addWidget(self.page2)

        self.page3 = QtWidgets.QWidget()
        self.page3.setObjectName("page3")

        self.frame_5 = QtWidgets.QFrame(parent=self.page3)
        self.frame_5.setGeometry(QtCore.QRect(10, 20, 821, 80))
        self.frame_5.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_5.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)

        self.frame_5.setObjectName("frame_5")

        self.label_4 = QtWidgets.QLabel(parent=self.frame_5)
        self.label_4.setGeometry(QtCore.QRect(40, 30, 94, 18))
        self.label_4.setObjectName("label_4")

        self.frame_7 = QtWidgets.QFrame(parent=self.page3)
        self.frame_7.setGeometry(QtCore.QRect(9, 119, 821, 281))
        self.frame_7.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_7.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_7.setObjectName("frame_7")
        
        self.frame_8 = QtWidgets.QFrame(parent=self.frame_6)
        self.frame_8.setGeometry(QtCore.QRect(40, 60, 671, 181))
        self.frame_8.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_8.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_8.setObjectName("frame_8")
        
        self.label_5 = QtWidgets.QLabel(parent=self.frame_8)
        self.label_5.setGeometry(QtCore.QRect(10, 10, 238, 18))
        self.label_5.setObjectName("label_5")
        
        self.label_6 = QtWidgets.QLabel(parent=self.frame_8)
        self.label_6.setGeometry(QtCore.QRect(30, 80, 369, 18))
        self.label_6.setObjectName("label_6")
        
        self.lineEdit_4 = QtWidgets.QLineEdit(parent=self.frame_8)
        self.lineEdit_4.setGeometry(QtCore.QRect(50, 120, 261, 26))
        self.lineEdit_4.setObjectName("lineEdit_4")
        
        self.frame_10 = QtWidgets.QFrame(parent=self.frame_8)
        self.frame_10.setGeometry(QtCore.QRect(29, 40, 531, 31))
        self.frame_10.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_10.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_10.setObjectName("frame_10")
        
        self.stackedWidget.addWidget(self.page2)
        
        self.page3 = QtWidgets.QWidget()
        self.page3.setObjectName("page3")
        
        self.frame_5 = QtWidgets.QFrame(parent=self.page3)
        self.frame_5.setGeometry(QtCore.QRect(10, 20, 821, 80))
        self.frame_5.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_5.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_5.setObjectName("frame_5")
        
        self.label_4 = QtWidgets.QLabel(parent=self.frame_5)
        self.label_4.setGeometry(QtCore.QRect(40, 30, 94, 18))
        self.label_4.setObjectName("label_4")
        
        self.frame_7 = QtWidgets.QFrame(parent=self.page3)
        self.frame_7.setGeometry(QtCore.QRect(9, 119, 821, 281))
        self.frame_7.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_7.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_7.setObjectName("frame_7")
                

        self.progressBar = QtWidgets.QProgressBar(parent=self.frame_7)
        self.progressBar.setGeometry(QtCore.QRect(20, 30, 781, 23))
        self.progressBar.setRange(0, 100)
        self.progressBar.setObjectName("progressBar")

        self.plainTextEdit = QtWidgets.QPlainTextEdit(parent=self.frame_7)
        self.plainTextEdit.setGeometry(QtCore.QRect(20, 70, 781, 201))
        self.plainTextEdit.setObjectName("plainTextEdit")
        self.plainTextEdit.setReadOnly(True)



        self.stackedWidget.addWidget(self.page3)

        self.page4 = QtWidgets.QWidget()
        self.page4.setObjectName("page4")

        self.page4 = QtWidgets.QWidget()        
        self.page4.setObjectName("page4")

        self.frame_9 = QtWidgets.QFrame(parent=self.page4)
        self.frame_9.setGeometry(QtCore.QRect(20, 20, 831, 451))
        self.frame_9.setFrameShape(QtWidgets.QFrame.Shape.StyledPanel)
        self.frame_9.setFrameShadow(QtWidgets.QFrame.Shadow.Raised)
        self.frame_9.setObjectName("frame_9")

        self.textBrowser_3 = QtWidgets.QTextBrowser(parent=self.frame_9)
        self.textBrowser_3.setGeometry(QtCore.QRect(10, 10, 811, 311))
        self.textBrowser_3.setObjectName("textBrowser_3")

        self.radio_button_group = QtWidgets.QVBoxLayout()


        self.stackedWidget.addWidget(self.page4)
        MainWindow.setCentralWidget(self.centralwidget)

        self.stackedWidget.addWidget(self.page4)
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        self.stackedWidget.setCurrentIndex(1)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        
        
        self.pages = [
            self.page1,
            self.page2,
            self.page3,
            self.page4
        ]

        
        self.base_widgets = [
            self.NextButton,
            self.PrevButton
            ]


        self.stackedWidget.setCurrentWidget(self.pages[0])

    def nextPage(self):
        if self.current_page_index == 1:
            self.exec_config_page()

        self.current_page_index += 1
        self.button_check()
        self.change_page()


    def prevPage(self):
        self.current_page_index = (self.current_page_index - 1)
        self.button_check()
        self.change_page()
        
    def button_check(self):
        if self.current_page_index + 1 == 4:
            self.NextButton.setEnabled(False)
            self.PrevButton.setEnabled(True)

        elif self.current_page_index+1 == 1:
            self.NextButton.setEnabled(True)
            self.PrevButton.setEnabled(False)

        else:
            self.NextButton.setEnabled(True)
            self.PrevButton.setEnabled(True)

    def DataUpdate(self,key,val):
        self.user_data[key] = val
        self.write_data()
        
    def exec_config_page(self):
        
            ## checking username
            if self.lineEdit.text() == '':
                self.error_window("USERNAME: Please type the Username !!")
                self.current_page_index = 0
            elif self.input_condition(self.lineEdit.text()):
                self.error_window("USERNAME: type conditions are only Alphabets and/or numbers")
                self.current_page_index = 0
            else:    
                self.DataUpdate("USERNAME",str(self.lineEdit.text()))
            
            ## checking password
            if self.lineEdit_2.text() == '' or self.lineEdit_3.text == '':
                self.error_window("PASSWORD: Please type your Passsword in both inputs")
                self.current_page_index = 0
            elif self.lineEdit_2.text() != self.lineEdit_3.text():
                self.error_window("PASSWORD: input lines doesn't match !!")
                self.current_page_index = 0
            elif self.input_condition(self.lineEdit_2.text()):
                self.error_window("PASSWORD Please no special characters in password")
            else:
                self.DataUpdate("PASSWORD",str(self.lineEdit_2.text()))

            # disk check
            if self.button_group.checkedButton() == None:
                self.error_window("DISK MANAGEMENT ERROR:\nno disk chosen.\nWhich disk would you want to choose ?")
                self.current_page_index = 0
            else:
                selected_button = self.button_group.checkedButton()
                selected_disk = selected_button.text()
                disk_name = selected_disk.split()
                self.updateDiskData(disk_name[0],disk_name[2])
                
            if self.lineEdit_4.text() != '':
                if self.Disk_Size_Check():
                    self.error_window('DISK MANAGEMENT ERROR:\nDisk space insufficient\nOR\nWritten incorrectly\nType for example (200G)')
                    self.current_page_index = 0
                else:
                    self.DataUpdate("PART4_SIZE",str(self.lineEdit_4.text()))


    def change_page(self):
        self.stackedWidget.setCurrentWidget(self.pages[self.current_page_index])
        if self.current_page_index == 1:
            self.create_radio_buttons()
        if self.current_page_index == 2:
            self.NextButton.setEnabled(False)
            self.PrevButton.setEnabled(False)
            self.install()
            self.NextButton.setEnabled(True)

    def write_data(self):
        with open(self.dataFile, 'w') as file:
            for key, value in self.user_data.items():
                file.write(f'{key}={value}\n')

    def error_window(self, message):
        msg_box = QtWidgets.QMessageBox()
        msg_box.setIcon(QtWidgets.QMessageBox.Icon.Critical)
        msg_box.setWindowTitle("Error")
        msg_box.setText("An error occurred:")
        msg_box.setInformativeText(message)
        msg_box.exec()

    def input_condition(self, text):
        if re.search(r'[^a-zA-Z0-9]', text):
            return 1
        return 0

    def Disk_Size_Check(self):
        size = self.lineEdit_4.text()
        if re.search(r'[^0-9MGT]',size):
            return 1
        return 0

    def create_radio_buttons(self):
        self.button_group = QtWidgets.QButtonGroup(parent=self.frame_10)
        options = info_disk()
        horizontal_layout = QtWidgets.QHBoxLayout()  # Create a horizontal layout
        for disk, (disk_name, disk_size) in enumerate(options):
            radio_button = QtWidgets.QRadioButton(f"{disk_name} - {disk_size}", parent=self.frame_10)
            self.button_group.addButton(radio_button, disk)
            horizontal_layout.addWidget(radio_button)  # Add radio button to the horizontal layout
        self.frame_10.setLayout(horizontal_layout)  # Set the horizontal layout to the frame
    
    def updateDiskData(self,name,value):
        self.user_data['DISK_NAME'] = f'/dev/{name}'
        self.user_data['PART1_SIZE'] = '200M'
        self.user_data['PART2_SIZE'] = '200M'
        self.user_data['PART3_SIZE'] = '2G'
        self.user_data['PART4_SIZE'] = value
        self.write_data()

    def install(self):
        self.start_process()

    def message(self, text):
        self.plainTextEdit.appendPlainText(text)

    def start_process(self):
        if self.process is None:  # No process running.
            self.message("Executing process")
            self.process = QProcess()  # Keep a reference to the QProcess (e.g. on self) while it's running.
            self.process.readyReadStandardOutput.connect(self.handle_stdout)
            self.process.readyReadStandardError.connect(self.handle_stderr)
            self.process.stateChanged.connect(self.handle_state)
            self.process.finished.connect(self.process_finished)  # Clean up once complete.
            self.process.start("bash", self.mainEntry)

    def handle_stderr(self):
        data = self.process.readAllStandardError()
        stderr = bytes(data).decode("utf8")
        progress = simple_percent_parser(stderr)
        if progress:
            self.progressBar.setValue(progress)
        self.message(stderr)

    def handle_stdout(self):
        data = self.process.readAllStandardOutput()
        stdout = bytes(data).decode("utf8")
        self.message(stdout)

    def handle_state(self, state):
        states = {
            QProcess.ProcessState.NotRunning: 'Not running',
            QProcess.ProcessState.Starting: 'Starting',
            QProcess.ProcessState.Running: 'Running',
        }
        state_name = states[state]
        self.message(f"State changed: {state_name}")

    def process_finished(self):
        self.message("Process finished.")
        self.process = None



    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.PrevButton.setText(_translate("MainWindow", "Previous"))
        self.NextButton.setText(_translate("MainWindow", "Next"))
        self.label.setText(_translate("MainWindow", "Linux From Scratch Installation Program"))
        self.textBrowser_2.setHtml(_translate("MainWindow", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"hr { height: 1px; border-width: 0; }\n"
"li.unchecked::marker { content: \"\\2610\"; }\n"
"li.checked::marker { content: \"\\2612\"; }\n"
"</style></head><body style=\" font-family:\'Cantarell\'; font-size:11pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Welcome to the Linux From Scratch Installation Program.</p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">This Program installes the Operating System of <a href=\"https://linuxfromscratch.org/lfs/downloads/12.1-systemd/\"><span style=\" text-decoration: underline; color:#2777ff;\">Linux From Scratch 12.1 systemd Book</span></a><a href=\"https://linuxfromscratch.org/lfs/downloads/12.1-systemd/\"><span style=\" text-decoration: underline; color:#000000;\"> </span></a><a href=\"https://linuxfromscratch.org/lfs/downloads/12.1-systemd/\"><span style=\" text-decoration: underline; color:#ffffff;\">.</span></a></p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; text-decoration: underline; color:#ffffff;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">All you have to do is to click on the Next button, complete the configuration page and wait a couple of hours... AND BOOM, you can boot on the LFS.</p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">If you have kali or any linux distro that uses a newer version of GRUB 2.12, Then you better go to the EFI Firmware Settings and place the the Disk of the LFS on top of others.</p></body></html>"))
        self.textBrowser.setHtml(_translate("MainWindow", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"hr { height: 1px; border-width: 0; }\n"
"li.unchecked::marker { content: \"\\2610\"; }\n"
"li.checked::marker { content: \"\\2612\"; }\n"
"</style></head><body style=\" font-family:\'Cantarell\'; font-size:11pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-weight:700;\">System Requirement:</span></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">    - CPU: AMD or Intel x86_64(64 bit) 8 cores or more required</p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">    - RAM: 8GB minumum, 16 recommended</p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">    - Disk Space: 8GB,  SSD recommended and <span style=\" font-weight:700; text-decoration: underline;\">MUST BE EMPTY</span></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-weight:700;\">    </span>- Host Operating System: any Linux Distribution (Ubuntu, Fedora, kali...)</p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p></body></html>"))
        self.label_2.setText(_translate("MainWindow", "UserName:"))
        self.label_3.setText(_translate("MainWindow", "Password"))
        self.label_8.setText(_translate("MainWindow", "Retype Password"))
        self.label_7.setText(_translate("MainWindow", "DISK MANAGEMENT:"))
        self.label_5.setText(_translate("MainWindow", "in which disk would you like to use ?"))
        self.label_6.setText(_translate("MainWindow", "Please type the size you need to allocate for the system:"))
        self.label_4.setText(_translate("MainWindow", "INSTALLING..."))
        self.textBrowser_3.setHtml(_translate("MainWindow", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"hr { height: 1px; border-width: 0; }\n"
"li.unchecked::marker { content: \"\\2610\"; }\n"
"li.checked::marker { content: \"\\2612\"; }\n"
"</style></head><body style=\" font-family:\'Cantarell\'; font-size:11pt; font-weight:400; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:20pt; font-weight:700;\">Congratulation, It\'s a penguin !!</span></p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:20pt; font-weight:700;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:16pt;\">You made it here, which means that the LFS system is installed properly.</span></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:16pt;\">So why don\'t you try and boot into it...</span></p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:16pt;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:16pt;\">However, if you\'re interested in our project then why don\'t you give it a try and build your OWN customized Linux Distribution.</span></p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:16pt;\"><br /></p>\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:16pt;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:16pt;\">Hurry up, go check </span><a href=\"https://linuxfromscratch.org/\"><span style=\" font-size:16pt; text-decoration: underline; color:#2777ff;\">THIS</span></a><span style=\" font-size:16pt;\"> </span></p></body></html>"))

    
if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec())
