class User < ActiveRecord::Base
  belongs_to :flat

  validates :name, presence: true
  validates :email, presence: true,
                    format: {with: /[0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/},
                    uniqueness: true


  def image_url(id)

      images=['http://media.licdn.com/mpr/mpr/wc_200_200/p/6/005/072/130/2cad0b9.jpg', #janes
      'http://media.licdn.com/mpr/mpr/wc_200_200/p/1/005/07b/2c2/2c34148.jpg', #kiko
      'http://media.licdn.com/media/p/4/005/075/0fd/14d641d.jpg', #elena
      'http://media.licdn.com/mpr/mpr/wc_200_200/p/8/005/027/00e/13790af.jpg',#cat
      'http://media.licdn.com/mpr/mpr/wc_200_200/p/3/005/072/29f/3c62b8c.jpg',#yo
      'http://media.licdn.com/media/p/8/005/038/0a7/1e4cee9.jpg' #kriss
    ]

    images[id-1]
  end
end
