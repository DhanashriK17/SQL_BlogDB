Create database Blogdb;
use Blogdb;

create table users( user_id int Primary key,
					username varchar(100) not null, 
                    password varchar(100) not null,
                    email varchar(100) not null);
   
 desc users;  
insert into users values(1,'user1', 'password1', 'user1@example.com');     
insert into users values(2,'user2', 'password2', 'user2@example.com');     
insert into users values(3,'user3', 'password3', 'user3@example.com');     
insert into users values(4,'user4', 'password4', 'user4@example.com');     
insert into users values(5,'user5', 'password5', 'user5@example.com');    
select * from users;  

create table posts( post_id int Primary key,
                    title varchar(100) not null,
                    content text not null,
                    user_id int not null,
                    FOREIGN KEY (user_id) REFERENCES Users(user_id)
                    );
   
desc posts;
INSERT INTO posts (post_id,title, content, user_id) VALUES
(1,'First Post', 'This is the content of the first post.', 1),
(2,'Second Post', 'Content of the second post.', 2),
(3,'Third Post', 'Content of the third post.', 3),
(4,'Fourth Post', 'Content of the fourth post.', 4),
(5,'Fifth Post', 'Content of the fifth post.', 5);
select * from posts;

create table comments( comment_id int primary key,
					    content text not null,
                        user_id int not null,
                        post_id int not null,
						FOREIGN KEY (user_id) REFERENCES Users(user_id),
                        FOREIGN KEY (post_id) REFERENCES Posts(post_id)
                        );
                        
desc comments;
INSERT INTO comments (comment_id,content, user_id, post_id) VALUES
(101,'Great post!', 2, 1),
(102,'Nice content!', 1, 2),
(103,'Great !', 3, 4),
(104,'Wonderful!', 4, 5),
(105,'Nice content!', 5, 3);
select * from comments;

create table categories( category_id int primary key,
                          name varchar(100) not null
                          );
                 
desc categories;
INSERT INTO categories (category_id,name) VALUES
(1001,'Technology'),
(1002,'Travel'),
(1003,'Food'),
(1004,'Management'),
(1005,'Medical');  
select * from categories;
 
 
-- Get all posts with their comments and authors: 
select posts.title, posts.content, users.username as author, comments.content as comment
from posts
join users on posts.user_id = users.user_id
left join comments on posts.post_id = comments.post_id;

-- Get the number of posts each user has:
select users.username, COUNT(posts.post_id) as post_count
from users
left join posts on users.user_id = Posts.user_id
group by Users.username;

-- Get the total number of comments on each post:
select posts.title, COUNT(comments.comment_id) as comment_count
from posts
left join comments on posts.post_id = comments.post_id
group by posts.title;

-- Find users who have not made any posts:
select users.username
from users
left join posts on users.user_id = posts.user_id
where posts.post_id is null;

-- Find posts with more than two comments:
select posts.title, COUNT(comments.comment_id) as comment_count
from posts
left join  comments on posts.post_id = comments.post_id
group by posts.title
having comment_count > 3;

-- Retrieve posts along with the number of comments for each post:
select posts.title, posts.content, COUNT(comments.comment_id) as comment_count
from posts
left join  comments ON posts.post_id = comments.post_id
group by posts.title, posts.content;

-- Find the users who have commented on a post:
select distinct users.username
from users
join comments on users.user_id = comments.user_id
where comments.post_id = 1;

-- Find the most recent post for each user:
select users.username, MAX(posts.post_id) as latest_post_id
from users
left join  posts on users.user_id = posts.user_id
group by users.username;

-- Retrieve the posts that do not have any comments:
select posts.title, posts.content
from posts
left join comments ON posts.post_id = comments.post_id
where comments.comment_id is null;


-- Retrieve the latest comments along with the post and user information:
select comments.content, posts.title as post_title, users.username as author
from comments
join  posts on comments.post_id = posts.post_id
join users on comments.user_id = users.user_id
ORDER BY comments.comment_id DESC
LIMIT 5; 


