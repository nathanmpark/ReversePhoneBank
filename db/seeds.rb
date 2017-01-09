address1 = Address.new(line_1: "101 Quintara St.",
                       line_2: nil,
                       city: 'San Francisco',
                       state: 'CA',
                       primary_zip: 94116,
                       extended_zip: nil)

address2 = Address.new(line_1: "12345 Dinosaur Lane",
                       line_2: nil,
                       city: 'San Francisco',
                       state: 'CA',
                       primary_zip: 94116,
                       extended_zip: nil)

user = User.create(first_name: 'Tom',
                   last_name: 'TomTom',
                   email: 'tom@tom.com',
                   phone: '(415) 555-0420',
                   address: address1,
                   user_type: 1)

user2 = User.create(first_name: 'Nathan',
                    last_name: 'Park',
                    email: 'Nathan@Park.com',
                    phone: '(123) 123-1234',
                    address: address2,
                    user_type: 1)

district1 = District.create(name: "California 1st",
                            state: "CA",
                            campaign_id: 1)

rep1 = Representative.create(district: district1,
                             rep_type: 1,
                             state: "CA",
                             first_name: "Jim",
                             last_name: "Jones",
                             party: 1)

campaign1 = Campaign.create(owner: user2,
                            title: "Education for kids",
                            description: "Kids need to learn things too",
                            start_date: DateTime.new,
                            end_date: DateTime.new + 10
                            )

campaign1.tags.create(name: "Education")
campaign1.tags.create(name: "Kids")


