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

  def self.all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    all_albums = results.map { |album| Album.new(album) }
    return all_albums
  end




end
