== README

Hey Classee Crew! I'm not sure how much experience you have with Ruby on Rails,
so I'll go over a few basics in this README.

Most everything you'll need to edit will be in the `/app` folder.
Under `/app/assets` you'll find the CSS (in `/app/assets/stylesheets`)
and javascript folders.

The HTML is found in `/app/views`.
The way Rails works is that the application is segmented into different
data structures that each have their own set of HTML templates.
The only important data structure for us right now is the "Student",
so all the pertinent HTML is in `/app/views/students`.

The way this data structure works is that there are many "students".
Each student has a few pieces of data associated with it:
* name
* major
* five classes, broken down as:
  * class1
  * class2
  * etc...

The name and major don't really do anything
(the name just distinguishes students), but the five classes are used
to construct the schedule.

The HTML is split into a few types of templates
(one for each type of page that a data element needs).
They are:
* <strong>Index:</strong> page that shows all of the students
* <strong>New:</strong> page to create a new student
* <strong>Show:</strong> page that displays an individual student
(with his/her name, major, and schedule)
* and a few more that we don't need to worry about right now

Edit these pages as you want. It should be fairly evident what the
HTML and embedded Ruby on each page is doing.

Rails can be run locally so that you can see your application live!
To do this, simply go to the project directory in your command line
and run `bin/rails server`. This will start up a local Rails server.
You can then go to `http://localhost:3000/` in your browser to view
the application live.

Have fun messing around, and let me (@ablelincoln AKA Andrew) know
if you have any questions or issues.

Stay classee
