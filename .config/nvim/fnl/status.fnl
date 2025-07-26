(local now _G.MiniDeps.now)

(now (fn []
    (let [statusline (require :mini.statusline)]
      (statusline.setup {
        :content {
            :active (fn []
               (local MiniStatusline (. _G :MiniStatusline))
               (let [(mode mode-hl) (MiniStatusline.section_mode { :trunc_width 120 })
                     diff          (MiniStatusline.section_diff { :trunc_width 75 })
                     diagnostics   (MiniStatusline.section_diagnostics { :trunc_width 75 })
                     lsp           (MiniStatusline.section_lsp { :trunc_width 75 })
                     git           (MiniStatusline.section_git { :trunc_width 40 })
                     filename      (MiniStatusline.section_filename { :trunc_width 140 })
                     fileinfo      (MiniStatusline.section_fileinfo { :trunc_width 120 })
                     search        (MiniStatusline.section_searchcount { :trunc_width 75 })
                     location      (MiniStatusline.section_location { :trunc_width  1000 })
                ]

                (MiniStatusline.combine_groups [
                    { :hl mode-hl                 :strings [ mode ] }
                    { :hl "MiniStatuslineDevinfo" :strings [ git diff diagnostics lsp ]}
                    "%<" 
                    { :hl "MiniStatuslineFilename" :strings [ filename ] }
                    "%=" 
                    { :hl "MiniStatuslineFileinfo" :strings [ fileinfo ] }
                    { :hl mode-hl                  :strings [ search location ] }
                ])))
            :inactive nil
        }
    }))))
