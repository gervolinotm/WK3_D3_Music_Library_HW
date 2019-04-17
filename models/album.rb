require('pg')
require_relative('artist.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (
      name,
      artist_id
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def list_artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_info = Artist.new(result[0])
    return artist_info
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def update()
    sql = "
    UPDATE albums SET (
      name,
      artist_id
    ) =
    (
      $1,$2
    )
    WHERE id = $3"
    values = [@name, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    all_albums = results.map { |album| Album.new(album) }
    return all_albums
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    album_found = Album.new(result[0])
    return album_found
  end




end
