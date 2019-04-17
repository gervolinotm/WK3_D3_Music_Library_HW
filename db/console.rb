require("pry")
require_relative("../models/artist")
require_relative("../models/album")

Artist.delete_all
Album.delete_all

artist1 = Artist.new({'name' => 'The Bugs'})
artist1.save()

album1 = Album.new({'name' => 'Pesticide'})
album1.save()

Artist.all()

p Album.all()

binding.pry
nil
