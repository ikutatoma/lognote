require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :likes
  has_many :courses
  has_many :user_courses, through: :courses, source: :user
  has_many :likes, through: :questions, source: :user
  has_secure_password
end

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :likes
  has_many :courses
  has_many :course_questions, through: :courses, source: :question
  has_many :likes, through: :users, source: :question
end

class Course < ActiveRecord::Base
  has_many :users
  has_many :user_courses, through: :users, source: :course
  has_many :questions
  has_many :course_questions, through: :questions, source: :course
end

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answer
end

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
end

class User_course < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
end

class Course_question <  ActiveRecord::Base
 belongs_to :course
 belongs_to :question
end