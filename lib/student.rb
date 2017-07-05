class Student
	attr_accessor :name, :grade
	attr_reader :id

	def initialize(new_name, new_grade, new_id = nil)
		@name = new_name
		@grade = new_grade
		@id = new_id
	end

	def self.create_table
		sql = <<-SQL
		CREATE TABLE IF NOT EXISTS students (
			id INTEGER PRIMARY KEY,
			name TEXT,
			grade INTEGER);
		SQL

		DB[:conn].execute(sql)
	end

	def self.drop_table
		sql = <<-SQL
		DROP TABLE students;
		SQL

		DB[:conn].execute(sql)
	end

	def save

		sql = <<-SQL
		INSERT INTO students (name, grade) 
		VALUES (?,?)
		SQL

		DB[:conn].execute(sql, self.name, self.grade)

		@id = DB[:conn].execute("SELECT id FROM students WHERE name  = '#{self.name}';")[0][0]
		self

	end

	def self.create(student_info_hash)
		new_student = self.new(student_info_hash[:name], student_info_hash[:grade])
		new_student.save
	end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
