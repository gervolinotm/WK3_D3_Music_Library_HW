require('pg')
require_relative('../db/sql_runner')
require_relative('./album.rb')


class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
    ) VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def list_all()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id]
    result =SqlRunner.run(sql, values)
    artist_albums = result.map { |album| Album.new(album)}
    return artist_albums
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "
    UPDATE artists SET
    name = $1
    WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    all_artists = results.map{ |artist| Artist.new(artist) }
    return all_artists
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    artist_found = Artist.new(result[0])
    return artist_found
  end





end
