require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def find_by_title(title)
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in DB" unless playwright

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end


end

class Playwright
  attr_accessor :name, :birth_year
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwright")
    data.map { |datum| Playwright.new(datum) }
  end

  def initialize(things)
    @id = things['id']
    @name = things['name']
    @birth_year = things['birth_year']
  end

  def create
    raise "#{self} already here dumbass" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
        playwrights
      VALUES
      (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not here..... dumbass" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays(name)
    raise "wtf am I doing" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        plays
      JOIN plays on playwrights.id = plays.playwright_id
      WHERE
        name = ?
    SQL
  end

  def find_by_name(name)
    raise "#{self} not in db" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
  end

end
