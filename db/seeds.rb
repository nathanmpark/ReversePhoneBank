address1 = Address.new(line_1: "1 W Portal Ave",
                       line_2: nil,
                       city: 'San Francisco',
                       state: 'CA',
                       primary_zip: 94127,
                       extended_zip: nil)

address2 = Address.new(line_1: "633 Folsom Street",
                       line_2: nil,
                       city: 'San Francisco',
                       state: 'CA',
                       primary_zip: 94107,
                       extended_zip: nil)

address3 = Address.new(line_1: "3820 N.W. 45th Street",
                       line_2: nil,
                       city: 'Gainesville',
                       state: 'FL',
                       primary_zip: 32606,
                       extended_zip: nil)


user1 = User.create(first_name: 'Tom',
                   last_name: 'TomTom',
                   email: 'tom@tom.com',
                   phone: '(415) 555-0420',
                   address: address1,
                   password: 'tomtom',
                   password_confirmation: 'tomtom',
                   user_type: 1)

user2 = User.create(first_name: 'Nathan',
                    last_name: 'Park',
                    email: 'Nathan@Park.com',
                    phone: '(123) 123-1234',
                    address: address2,
                    password: 'tomtom',
                    password_confirmation: 'tomtom',
                    user_type: 1)

user3 = User.create(first_name: 'Tina',
                   last_name: 'TinaTina',
                   email: 'tina@tina.com',
                   phone: '(415) 555-0490',
                   address: address1,
                   password: 'tomtom',
                   password_confirmation: 'tomtom',
                   user_type: 1)

user4 = User.create(first_name: 'Levis',
                   last_name: 'Walker',
                   email: 'levis@walker.com',
                   phone: '(352) 555-0420',
                   address: address3,
                   password: 'tomtom',
                   password_confirmation: 'tomtom',
                   user_type: 1)

campaign1 = Campaign.create(owner: user2,
                            title: "Education for kids",
                            description: "Kids need to learn things too",
                            start_date: DateTime.new,
                            end_date: DateTime.new + 10
                            )

campaign1.users << user1
campaign1.users << user3
campaign1.users << user4

campaign1.tags.create(name: "Education")
campaign1.tags.create(name: "Kids")


