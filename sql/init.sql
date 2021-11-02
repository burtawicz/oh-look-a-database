create table customers (
    id serial not null primary key,
                   first_name text not null,
    last_name        text not null,
    date_of_birth       date not null,
    is_verified bool not                        null default false,
    created_at     timestamp     not null      default now()
);

insert into customers (first_name, last_name, date_of_birth)
values ('Alan', 'Turing', '1912-06-23'),
       ('Srinivasa', 'Ramanujan', '1887-12-22'),
       ('Julian', 'Schwinger', '1918-02-12'),
       ('Richard', 'Feynman', '1918-05-11'),
       ('Max', 'Planck', '1858-04-23'),
       ('George', 'Boole', '1815-11-02'),
       ('Frank', 'Gray', '1887-09-13'),
       ('Christopher', 'Hitchens', '1949-04-13');

create table publishers (
    id serial not null primary key,
    name text not null,
    created_at              timestamp default now()
);

create unique index publisher_name_uidx on publishers (name);

insert into publishers (name)
values ('WEMAKEGAMES LLC'),
       ('A Game Company Ltd'),
       ('Some Other Game Company Inc'),
       ('Yet Another Game Company Ltd'),
       ('The Puzzle Cube Company Inc'),
       ('Secretly Stealing Your Personal Data LLC'),
       ('Distributed Factorial Shuffling Inc'),
       ('Fake Trading Card Game Manufacturer LLC');

create table products (
    id serial not null primary key,
    title text not null,
    publisher_id int not null constraint publisher_id_fk references publishers (id),
    stock int,
    created_at timestamp not null default now()
);

insert into products (title, publisher_id, stock)
VALUES ('3x3x3 Puzzle Cube', 5, 10),
       ('4x4x4 Puzzle Cube', 5, 10),
       ('99x99x99 Puzzle Cube', 5, 23),
       ('Infinity Puzzle Cube', 5, 5),
       ('My Little Sconey 6-pack', 6, 293),
       ('Johnmas the Locomotive Vehicle', 1, 2),
       ('Dortcheemans - EZ Shake Coven Expansion Pack', 8, 62),
       ('Dortcheemans - Starter Pack', 8, 13),
       ('2Weeks Battle Royale - 46 WBucks', 2, 99),
       ('25Cent Life-sized Action Figure', 7, 3),
       ('Greendale College Diploma', 4, 234295),
       ('Forest Gumpkin', 3, 734),
       ('Bologna Meat Seltzer', 6, 934592);

create table product_details (
    id int not null primary key constraint          product_detail_product_id_fk references products (id),
    price                               numeric(6,              2) not null,
    summary text not null,
    created_at timestamp not null default now()
);

insert into product_details (id, price, summary)
VALUES (1, 15.99, 'A 3x3x3 puzzle cube that is great for cubers of all levels!'),
       (2, 25.99, 'A 4x4x4 puzzle cube for masters of the 3x3x3 looking for a new challenge.'),
       (3, 99.99, 'A 99x99x99 puzzle cube for cubing enthusiasts who want to show off and alienate their friends.'),
       (4, 99.99, 'A infinite cube for those with nothing but time.'),
       (5, 29.99, '6 random figurines from the hit show My Little Sconey. Will you get Sconey, Muffintop, The Strudler, Flakey Frank, Joe of Louis, Berry David, Richard Cheewis, or Jeff Garlicbun? COLLECT THEM ALL!!!'),
       (6, 75.99, 'From the hit show Johnmas the Locomotive Vehicle and Acquaintances we bring you Johnmas. Rideable by small children and foolish adults alike.'),
       (7, 39.99, '45 Dortcheemans cards from the EZ Shake Coven series. Shaking not encouraged.'),
       (8, 129.99, 'The Dortcheemans starter pack includes 23 cards to get you started. Note, 46 cards are required to play the game.'),
       (9, 92.99, 'Virtual currency card for the smash hit game 2Weeks.'),
       (10, 35.99, 'Life-sized action figure of rapper 25Cent. Stands approximately 355cm talls, weighs 250kg, may come to life, no returns.'),
       (11, 0.99, 'A genuine college diploma from Greendale community college. Fool employers into thinking you came to do business. In-dean-ius.'),
       (12, 39.99, 'A must-have pumpkin-themed reboot of the classic film.'),
       (13, 0.00, 'A tangy meat-flavoured seltzer. Please get these out of my store!');


create table product_reviews (
    id serial not null primary key,
    customer_id int not null constraint product_review_customer_id_fk references customers (id),
    product_id int not null constraint product_review_product_id_fk references products (id),
    review text not null,
    rating int default 0,
    created_at timestamp default now()
);

insert into product_reviews (customer_id, product_id, review, rating)
values (4, 4,            'First of all, this is technically impossible. Second, I solved it in under 10 minutes. Eat them apples, Schwinger.', 4),
       (8, 13,      'This is the single worst beverage that I have had the displeasure of consuming. Give it to the Pope.', 1),
       (4, 11,       'This is about as useful as any other diploma.', 4),
       (6, 9,      'As I understand it, the school of logic that I developed paved the way for this travesty. Thoroughly disappointed.', 2),
       (6,              13,     'Quite a tasty beverage. Much better than haggis.', 5),
       (7, 7, 'Great set. Does anyone have Complainamon? I would be willing to trade my 4" television for it...', 3),
       (2, 5,           'I L-O-V-E My Little Sconey. Berry David is my favourite!', 5),
       (        1, 12, 'My only regret is that I focused on creating computers instead of this masterpiece.', 5),
       (3, 13, 'Accursed beverage. Most certainly not for the pallets of the intelligencia!', 1),
       (3, 4, 'Did you actually solve it Feynman, or did you just approximate it?', 2),
       (5, 6, 'This is greatest collectible that I have ever encountered.', 5)