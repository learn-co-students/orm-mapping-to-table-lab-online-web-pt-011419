class Student

  
  attr_reader :id
  attr_accessor :name, :grade
 
 
  def initialize (name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end
 
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        grade INTEGER
        )
        SQL
    DB[:conn].execute(sql) 
  end


  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students
    SQL
    
    DB[:conn].execute(sql)
    
  end
  
  def save
    sql = <<-SQL
              INSERT INTO students (name, grade) 
              VALUES (?, ?)
             SQL
 
    DB[:conn].execute(sql, self.name, self.grade)
    sid = <<-SQL
              SELECT last_insert_rowid()
             SQL
    
    @id = DB[:conn].execute(sid).first.join.to_i
    
  end
  
  def self.create(name:,grade:)
    student = Student.new(name,grade)
    student.save
    student
  end
  
  
  
  
  
end
