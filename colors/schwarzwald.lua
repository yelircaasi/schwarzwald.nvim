for k in pairs(package.loaded) do
  if k:match('.*schwarzwald.*') then
    package.loaded[k] = nil
  end
end

require('schwarzwald').setup()
require('schwarzwald').colorscheme()
