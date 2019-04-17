require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :name, :id
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

  def self.all()
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    all_artists = results.map { |artist| Artist.new(artist) }
    return all_artists
  end




end
