class Season < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '春' },
    { id: 3, name: '夏' },
    { id: 4, name: '秋' },
    { id: 5, name: '冬' },
    { id: 6, name: '暮・新年' },
  ]

  include ActiveHash::Associations
  has_many :themes

  end