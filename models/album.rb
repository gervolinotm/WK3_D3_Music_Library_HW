require('pg')

class Album

  attr_reader :name, :id, :artist_id

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

  def self.all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    all_albums = results.map { |album| Album.new(album) }
    return all_albums
  end

  def Album.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end




end
