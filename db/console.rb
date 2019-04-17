require("pry")
require_relative("../models/artist")
require_relative("../models/album")

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'The Bugs'})
artist1.save()
artist2 = Artist.new({'name' => 'THE STOOGES'})
artist2.save()

album1 = Album.new({'name' => 'Pesticide', 'artist_id' => artist1.id})
album1.save()

album2 = Album.new({'name' => 'Picnic Suicide', 'artist_id' => artist2.id})
album2.save()

album3 = Album.new({'name' => 'BBQ Resurrection', 'artist_id' => artist2.id})
album3.save()


# artist2.name = 'THE POOCHES'
# artist2.update()
# album1.delete
# artist1.delete

p Album.find(65)

binding.pry
nil
