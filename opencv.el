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



(provide 'opencv)

;;; opencv.el ends here
