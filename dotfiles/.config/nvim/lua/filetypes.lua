vim.filetype.add({
  pattern = {
    -- ansible
    ['.*a(a|A)nsible.*.ya?ml'] = 'yaml.ansible',
    ['.*/RubyConfig/.*.ya?ml'] = 'yaml.ansible',

    -- compose
    ['.*compose.*.ya?ml'] = 'yaml.docker-compose',

    ['.*.env'] = 'none',
  },
})
