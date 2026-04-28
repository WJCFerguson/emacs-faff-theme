;;; faff-theme.el --- Light cornsilk theme with warm, earthy colors -*- lexical-binding:t -*-

;; Copyright (C) 2003-2026 Free Software Foundation, Inc.

;; Author: James Ferguson <(concat "wjcferguson" at-sign "gmail.com")>
;; URL: https://github.com/WJCFerguson/emacs-faff-theme
;; Version: 4.0.3
;; Package-Requires: ((emacs "28.1") (modus-themes "5.0.0"))
;; Keywords: faces, theme

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; A warm, earthy light theme with a cornsilk3 background, built on top
;; of the `modus-themes' framework.  Adopts palette mapping refinements
;; from `ef-themes-palette-common' for subtler UI defaults; see the
;; "Adopted from ef-themes" block in the mappings to revert to stock
;; modus behavior.
;;
;; To use it, put the following in your Emacs configuration file:
;;
;;   (load-theme 'faff t)

;;; Code:

(require 'modus-themes)

(defconst faff-palette-partial
  '(;; Core UI colors
    (cursor "#cd0000")              ; red3
    (bg-main "#cdc8b1")            ; cornsilk3
    ;; NOTE: bg-dim is intentionally lighter than bg-main (inverted from
    ;; the modus convention) so that code blocks, diff context, and prose
    ;; blocks appear as subtle highlights rather than dimmed areas.
    (bg-dim "#e0dbc0")             ; lighter than main (code blocks, diff context)
    (bg-alt "#b0ab96")             ; chrome (tab bar, inactive mode line)
    (fg-main "#000000")            ; black
    (fg-dim "#8b8878")             ; cornsilk4
    (fg-alt "#345160")             ; muted steel (cyan-faint)
    (bg-active "#a5a08c")
    (bg-inactive "#eee8cd")        ; cornsilk2
    (border "#8b8878")             ; cornsilk4

    ;; Base/warmer/cooler contrast: 5.5:1 (blue 7:1, cyan 6.5:1).
    ;; Faint contrast: 4.5-5.0:1.
    ;; Hue spreads hand-tuned per family.
    ;; Base hues: red=5 yellow=36 green=140 cyan=200 blue=230 magenta=305

    ;; Red H=5, warmer→25, cooler→340 (35° spread, S=85/35)
    (red "#8e160c")
    (red-warmer "#743609")
    (red-cooler "#8f0c37")
    (red-faint "#7f433d")

    ;; Green H=140, warmer→95, cooler→170 (75° spread, S=85/20)
    (green "#004a12")
    (green-warmer "#144800")
    (green-cooler "#004830")
    (green-faint "#224e2e")

    ;; Yellow H=36, warmer→22, cooler→45 (23° spread, S=85/35)
    (yellow "#644008")
    (yellow-warmer "#79320a")
    (yellow-cooler "#594507")
    (yellow-faint "#665131")

    ;; Blue H=230, warmer→250, cooler→218 (32° spread, S=75/35, 7:1)
    (blue "#152a93")
    (blue-warmer "#2f18a4")
    (blue-cooler "#113574")
    (blue-faint "#3a4477")

    ;; Magenta H=305, warmer→335, cooler→275 (60° spread, S=80/30)
    (magenta "#810e78")
    (magenta-warmer "#8c1043")
    (magenta-cooler "#6a13a8")
    (magenta-faint "#784073")

    ;; Cyan H=200, warmer→180, cooler→215 (35° spread, S=85/30, 6.5:1)
    (cyan "#08415d")
    (cyan-warmer "#064444")
    (cyan-cooler "#0a3a7e")
    (cyan-faint "#345160")

    ;; Intense backgrounds (for search highlights etc.)
    (bg-red-intense "#ff8f88")
    (bg-green-intense "#80ff80")
    (bg-yellow-intense "#ffff40")
    (bg-blue-intense "#aabbff")
    (bg-magenta-intense "#d09fff")
    (bg-cyan-intense "#80d8c0")

    ;; Subtle backgrounds
    (bg-red-subtle "#efcabf")
    (bg-green-subtle "#c3e6a0")
    (bg-yellow-subtle "#efe07f")
    (bg-blue-subtle "#c7dbe8")
    (bg-magenta-subtle "#e3d0e7")
    (bg-cyan-subtle "#bfe0d0")

    ;; Diff backgrounds
    (bg-added "#c8e0b8")
    (bg-added-faint "#d4e4c8")
    (bg-added-refine "#b8d8a5")
    (fg-added "#004500")

    (bg-changed "#e8e0a0")
    (bg-changed-faint "#ede6b8")
    (bg-changed-refine "#e0d690")
    (fg-changed "#553d00")

    (bg-removed "#e8c8b0")
    (bg-removed-faint "#e8d4c0")
    (bg-removed-refine "#e0b8a0")
    (fg-removed "#8f1013")

    ;; UI element backgrounds
    (bg-mode-line-active "#ffd700") ; gold
    (fg-mode-line-active "#000000")
    (fg-mode-line-inactive "#50504a") ; readable against bg-alt
    (bg-completion "#dfd8c0")
    (bg-hover "#c0cbd7")
    (bg-hover-secondary "#c5d8a2")
    (bg-hl-line "#ddd8bd")
    (bg-paren-match "#9fd0cc")
    (bg-err "#ffbbbb")
    (bg-warning "#efe07f")
    (bg-info "#cdeeb0")
    (bg-region "#e0dcc8")))

(defconst faff-palette-mappings-partial
  '((err red-warmer)
    (warning yellow-warmer)
    (info green)

    (fg-link blue-warmer)
    (fg-link-visited magenta-faint)
    (name green)
    (keybind red-warmer)
    (identifier cyan-faint)
    (fg-prompt blue-warmer)

    (builtin blue-cooler)
    (comment red)
    (constant cyan-cooler)
    (fnname blue-cooler)
    (fnname-call blue-cooler)
    (keyword fg-main)
    (preprocessor magenta-cooler)
    (docstring red)
    (string green-warmer)
    (type green)
    (variable fg-main)
    (variable-use fg-main)
    (rx-backslash magenta-warmer)
    (rx-construct blue-cooler)

    (accent-0 red-warmer)
    (accent-1 green)
    (accent-2 blue)
    (accent-3 yellow-warmer)

    (date-common cyan-faint)
    (date-deadline red-warmer)
    (date-deadline-subtle red)
    (date-event fg-alt)
    (date-holiday red-warmer)
    (date-now fg-main)
    (date-range fg-alt)
    (date-scheduled yellow-cooler)
    (date-scheduled-subtle yellow-faint)
    (date-weekday red)
    (date-weekend cyan)

    (fg-prose-code green-cooler)
    (prose-done green)
    (fg-prose-macro blue)
    (prose-metadata fg-dim)
    (prose-metadata-value fg-alt)
    (prose-table fg-alt)
    (prose-table-formula warning)
    (prose-tag yellow-faint)
    (prose-todo red-warmer)
    (fg-prose-verbatim red-cooler)

    (mail-cite-0 red)
    (mail-cite-1 yellow)
    (mail-cite-2 green)
    (mail-cite-3 blue-faint)
    (mail-part green-cooler)
    (mail-recipient yellow)
    (mail-subject red-warmer)
    (mail-other yellow-warmer)

    (bg-search-static bg-warning)
    (bg-search-current bg-yellow-intense)
    (bg-search-lazy bg-cyan-intense)
    (bg-search-replace bg-red-intense)

    (bg-search-rx-group-0 bg-magenta-intense)
    (bg-search-rx-group-1 bg-green-intense)
    (bg-search-rx-group-2 bg-red-subtle)
    (bg-search-rx-group-3 bg-cyan-subtle)

    (bg-space-err bg-yellow-intense)

    ;; Faff-specific UI overrides
    (bg-tab-bar bg-alt)
    (bg-tab-other bg-alt)           ; inactive tabs match tab bar
    (bg-mode-line-inactive bg-alt)
    (fg-region unspecified)         ; let text colors show through selection
    (fringe unspecified)            ; fringe matches background

    ;; Adopted from ef-themes-palette-common: refinements over modus
    ;; defaults for subtler links, cleaner search/completion, and simpler
    ;; mark/prominent/argument colors.  Remove this block to revert to
    ;; stock modus-themes behavior.
    (property variable)
    (bg-diff-context bg-dim)
    (fg-link-symbolic fg-alt)
    (underline-link border)
    (underline-link-visited border)
    (underline-link-symbolic border)
    (bg-line-number-active unspecified)
    (fg-line-number-active accent-0)
    (bg-line-number-inactive unspecified)
    (bg-prominent-err bg-err)
    (bg-prominent-warning bg-warning)
    (bg-prominent-note bg-info)
    (fg-prominent-err err)
    (fg-prominent-warning warning)
    (fg-prominent-note info)
    (bg-active-argument bg-warning)
    (fg-active-argument warning)
    (bg-active-value bg-info)
    (fg-active-value info)
    (bg-mark-delete bg-err)
    (fg-mark-delete err)
    (bg-mark-select bg-info)
    (fg-mark-select info)
    (bg-mark-other bg-warning)
    (fg-mark-other warning)
    (fg-search-current fg-main)
    (fg-search-lazy fg-main)
    (fg-search-static fg-main)
    (fg-search-replace fg-main)
    (fg-search-rx-group-0 fg-main)
    (fg-search-rx-group-1 fg-main)
    (fg-search-rx-group-2 fg-main)
    (fg-search-rx-group-3 fg-main)
    (fg-completion-match-0 accent-0)
    (fg-completion-match-1 accent-1)
    (fg-completion-match-2 accent-2)
    (fg-completion-match-3 accent-3)

    (rainbow-0 red)
    (rainbow-1 magenta-cooler)
    (rainbow-2 green)
    (rainbow-3 yellow-cooler)
    (rainbow-4 blue)
    (rainbow-5 cyan)
    (rainbow-6 red-warmer)
    (rainbow-7 green-cooler)
    (rainbow-8 magenta-faint)))

(defcustom faff-palette-overrides nil
  "Overrides for `faff-palette'.

Mirror the elements of the aforementioned palette, overriding
their value.

For overrides that are shared across all Modus-derived themes,
refer to `modus-themes-common-palette-overrides'."
  :group 'modus-themes
  :package-version '(faff-theme . "4.0")
  :type '(repeat (list symbol (choice symbol string))))

(defconst faff-custom-faces
  '(;; Magit boxed refs
    `(magit-branch-local ((,c :background ,bg-yellow-intense :box (:line-width 1 :color ,border))))
    `(magit-branch-current ((,c :inherit magit-branch-local :background ,bg-green-intense :weight bold)))
    `(magit-branch-remote ((,c :background ,bg-inactive :foreground ,green-cooler :box (:line-width 1 :color ,border))))
    `(magit-section-heading ((,c :inherit modus-themes-bold :box (:line-width 1 :color ,border))))
    `(magit-tag ((,c :background ,bg-inactive :foreground ,yellow :box (:line-width 1 :color ,fg-dim))))
    `(magit-refname ((,c :foreground ,fg-dim :box (:line-width 2 :color ,border))))
    `(magit-hash ((,c :foreground ,fg-dim)))
    ;; Diff: add boxes to modus defaults
    `(diff-file-header ((,c :inherit modus-themes-bold :box (:line-width 2 :color ,border))))
    `(diff-hunk-header ((,c :inherit modus-themes-bold :background ,bg-inactive :box (:line-width 2 :color ,border))))
    ;; Org agenda boxed headers
    `(org-agenda-date ((,c :inherit org-agenda-structure :background ,bg-inactive :box (:line-width 1 :color ,border))))
    `(org-agenda-structure ((,c :background ,bg-inactive :foreground ,blue :box (:line-width 1 :color ,border))))
    ;; dired-filetype
    `(dired-filetype-compress ((t :foreground ,magenta)))
    `(dired-filetype-execute ((t :foreground ,green :weight bold)))
    `(dired-filetype-omit ((t :foreground ,fg-dim)))
    `(dired-filetype-plain ((t :foreground ,green-cooler)))
    `(dired-filetype-source ((t :foreground ,red)))
    `(dired-filetype-video ((t :foreground ,yellow-warmer)))
    `(dired-filetype-js ((t :foreground ,yellow)))
    `(dired-filetype-program ((t :foreground ,green)))))

(defconst faff-palette
  (modus-themes-generate-palette
   faff-palette-partial
   nil
   nil
   faff-palette-mappings-partial))

(modus-themes-theme
 'faff
 nil
 "Light cornsilk theme with warm, earthy colors."
 'light
 'faff-palette
 nil
 'faff-palette-overrides
 'faff-custom-faces)

;;; faff-theme.el ends here
