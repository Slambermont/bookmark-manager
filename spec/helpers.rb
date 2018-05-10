def add_bookmarks
  connection = PG.connect( dbname: 'bookmark_manager_test')
  connection.exec("INSERT INTO bookmarks(url, title) VALUES('http://makersacademy.com','Makers');")
  connection.exec("INSERT INTO bookmarks(url, title) VALUES('http://google.com','Google');")
  connection.exec("INSERT INTO bookmarks(url, title) VALUES('http://destroyallsoftware.com','Destroy');")
end
