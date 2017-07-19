namespace :populate do

  desc 'Populates db with test questions'
  task questions: :environment do

    # load yml file first
    path = Rails.root.join('db', 'seeds', 'sas-samples.yml')
    puts "using file #{path}"
    File.open(path) do |file|
      YAML.load_documents(file) do |doc|

        # define vars to be used
        SAS_SAMPLES = doc['samples'].collect do |sample| 
          sample.inspect[1..-2].split('\n').collect{ |lines| "    #{lines.gsub('\\', '')}" }.join("\r\n")
        end
        USER = User.first
        CHOICES = ['multiple', 'simple', 'multiple', 'user input', 'multiple']
        TAGS = ["SAS Programming", "SAS Macro", "DI Studio", "SAS Management Console", "Enterprise Guide", "Workspace Management"]

        500.times do
          # random choices for this questions
          use_sas_sample = true || Faker::Boolean.boolean
          current_choice = CHOICES[Faker::Number.number(1).to_i % CHOICES.size]

          question_attributes = {
            user_id: USER.id,
            title: Faker::Name.title,
            description_markdown: '',
            explanation_markdown: Faker::Lorem.paragraph(3, true, 5),
            choice: current_choice,
          }

          if use_sas_sample
            question_attributes[:description_markdown] = 
              SAS_SAMPLES[Faker::Number.number(100).to_i % SAS_SAMPLES.size]
          else
            question_attributes[:description_markdown] = Faker::Lorem.paragraph(4, true, 6)
          end

          correct_answer = Faker::Lorem.word
          question_attributes[:description_markdown] += "\r\n\r\ncorrect_answer: #{correct_answer}\r\n"
          
          new_question = Question.new(question_attributes)
          new_question.tag_list = TAGS.sample(2)

          # create a correct answer
          new_question.answers << Answer.new({
                                    question_id: new_question.id,
                                    is_correct: true,
                                    answer_markdown: correct_answer
                                  })

          case current_choice
          when 'multiple'
            # in case of multiple, add additional incorrect answers
            2.times do
              new_question.answers << Answer.create({
                                        question_id: new_question.id,
                                        is_correct: false,
                                        answer_markdown: Faker::Lorem.word
                                      })
            end
          when 'simple'
          when 'user input'
          end
          
          # save question with tags and answers
          new_question.save
        end

      end
    end

  end
end
