-- enable partial word motions with , for camel case segments
return {
  "chrisgrieser/nvim-spider",
  name = "spider",
  opts = {
    skipInsignificantPunctuation = true,
  },
}
