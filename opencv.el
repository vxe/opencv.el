;;; opencv.el --- tools for interaction with a system installation of opencv

;; Copyright (C) 2018 Vijay Edwin

;; Author: Vijay Edwin <vedwin@vijays-mbp.localhost>
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.*

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; tools for interaction with a system installation of opencv

;;; Code:

(defcustom opencv:minimum-version "2.8"
  "Where to put newly created notes."
  :group 'opencv
  :type 'string)

(defcustom opencv:c++-file-extension "cc"
  "The extension to add to generated source files."
  :group 'opencv
  :type 'string)

(defcustom opencv:generated-source-filename "App"
  "The extension to add to generated source files."
  :group 'opencv
  :type 'string)


(defun opencv:display-file-text ()
  "Source text for the image display example."
  (interactive)
  (insert
   (concat "#include <opencv2/opencv.hpp> //Include file for every supported OpenCV function\n\nint main( int argc, char** argv ) {\n  cv::Mat img = cv::imread(argv[1],-1);\n  if( img.empty() ) return -1;\n  cv::namedWindow( \"Example 2-1\", cv::WINDOW_AUTOSIZE );\n  cv::imshow( \"Example 2-1\", img );\n  cv::waitKey( 0 );\n  cv::destroyWindow( \"Example 2-1\" );\n  return 0;\n}\n")))

(defun opencv:hello-world-text ()
  "Generate a minimal CMakeLists.txt in the current buffer."
  (concat "#include <opencv2/core.hpp> \n#include <opencv2/imgproc.hpp> \n#include <opencv2/highgui.hpp>\n#include <iostream>\n\n\nint main(int argc, char **argv){\n    std::cout << \"Number of arguments: \" << argc << std::endl;\n    for(size_t i = 0; i < argc; i++)\n        std::cout << \"  Argument \" << i << \" = '\" << argv[i] << \"'\" << std::endl;\n}\n"))

(defun opencv:cmake-template ()
  "Generate a minimal CMakeLists.txt in the current buffer."
  (concat
   "cmake_minimum_required(VERSION " opencv:minimum-version ")\n
set (CMAKE_CXX_STANDARD 11)\n
project( DisplayImage )\n
find_package( OpenCV REQUIRED )\n
add_executable( DisplayImage " opencv:generated-source-filename ")\n
target_link_libraries( DisplayImage ${OpenCV_LIBS} )"))

(defun opencv:gen-cmake-file ()
  "Generate a minimal CMakeLists.txt in the current buffer."
  (interactive)
  (insert (concat
           "cmake_minimum_required(VERSION " opencv:minimum-version ")\n
set (CMAKE_CXX_STANDARD 11)\n
project( DisplayImage )\n
find_package( OpenCV REQUIRED )\n
add_executable( DisplayImage hello.cc)\n
target_link_libraries( DisplayImage ${OpenCV_LIBS} )")))


(defun opencv:project-template (project-name)
  "Template a basic opencv project named PROJECT-NAME with the file ENTRY-POINT configured such that it will compile."
  (interactive "sproject-name: ")
  (shell-command (concat "mkdir -p " project-name))
  (with-temp-buffer
    (let ((program-text (opencv:hello-world-text))
          (template (opencv:cmake-template)))
      (cd project-name)
      (shell-command (concat "touch " opencv:generated-source-filename "." opencv:c++-file-extension))
      (f-write template  'utf-8 "CMakeLists.txt")
      (f-write program-text 'utf-8 (concat opencv:generated-source-filename "." opencv:c++-file-extension)))))


(provide 'opencv)

;;; opencv.el ends here
