--Показать все книги, количество страниц в которых больше 500, но меньше 650.
select Name as [книги]
from books
where Pages > 500 and Pages<650

--Показать все книги, в которых первая буква названия либо «А», либо «З».
select Name as [книги]
from books
where Name like 'А%' or Name like 'З%'

--Показать все книги жанра «Детектив», количество проданных книг более 30 экземпляров.
select b.Name
from books b, sales s, themes t
where t.id = b.ThemeId and s.Bookid = b.id and t.Name like 'Детектив' and Quantity > 30

--Показать все книги, в названии которых есть слово "Microsoft" но нет слова "Windows"
select Name
from books 
where Name like '%Microsoft%' and Name not like '%Windows%'

--Показать все книги (название, тематика, полное имя автора в одной ячейке), цена одной страницы которых меньше 65 копеек.
select b.Name + ' ' + t.Name + ' ' + a.Name + ' ' + a.Surname as [книги]
from books b, themes t, authors a 
where t.id = b.ThemeId and a.id = b.AuthorId and b.Price < 65

--Показать все книги, название которых состоит из 4 слов.
select Name
from books 
where Name like '%_ %_ %_ %_'  and Name not like '%_ %_ %_ %_ %_'

--Показать информацию о продажах в следующем виде: 
--▷ Название книги, но, чтобы оно не содержало букву «А».
--▷ Тематика, но, чтобы не «Программирование».
--▷ Автор, но, чтобы не «Герберт Шилдт».
--▷ Цена, но, чтобы в диапазоне от 10 до 20 гривен.
--▷ Количество продаж, но не менее 8 книг.
--▷ Название магазина, который продал книгу, но он не должен быть в Украине или России.
select Name 
from books
where Name not like '%А%'

select Name 
from themes
where Name not like 'Программирование'

select Name + ' ' + Surname 
from authors
where Name + ' ' + Surname not like 'Герберт Шилдт'

select Price 
from books
where Price > = 10 and Price <= 20 

select Quantity
from sales
where Quantity >= 8

select s.Name
from shops s, countries c
where c.id = s.CountryId and c.Name not like 'Украина' and c.Name not like 'Россия'




select Name 
from books
where Name not like '%А%'
union all
select Name 
from themes
where Name not like 'Программирование'
union all
select Name + ' ' + Surname as autor
from authors
where Name + ' ' + Surname not like 'Герберт Шилдт'
union all
select convert(nvarchar(5),Price) 
from books
where Price > = 10 and Price <= 20
union all
select convert(nvarchar(5),Quantity)
from sales
where Quantity >= 8
union all
select s.Name
from shops s, countries c
where c.id = s.CountryId and c.Name not like 'Украина' and c.Name not like 'Россия'

--Показать следующую информацию в два столбца (числа в правом столбце приведены в качестве примера):
--▷ Количество авторов: 14
--▷ Количество книг: 47
--▷ Средняя цена продажи: 85.43 грн.
--▷ Среднее количество страниц: 650.6.

select 'Количество авторов:' as [информация], count(Name) as [данные]
from authors
union
select 'Количество книг:' as [информация], count(Name) as [данные]
from books
union
select 'средняя цена продажи:' as [информация], avg(Price) as [данные]
from books
union
select 'среднее количество страниц:' as [информация], avg(Pages) as [данные]
from books

--Показать тематики книг и сумму страниц всех книг по каждой из них.
select t.Name, sum(b.Pages) as [количество страниц]
from themes t, books b
where t.id = b.ThemeId
group by t.Name

--Показать количество всех книг и сумму страниц этих книг по каждому из авторов.
select a.Name + ' ' + a.Surname as autor, count(b.Name) as kolKnig, sum(b.Pages) as kolStranic
from authors a, books b
where a.id = b.AuthorId
group by a.Name + ' ' + a.Surname

--Показать книгу тематики «Программирование» с наибольшим количеством страниц
select max(b.Pages)
from books b, themes t
where t.id = b.ThemeId and t.Name like 'Программирование'

--Показать среднее количество страниц по каждой тематике,которое не превышает 400.
select t.Name, avg(b.Pages) as [среднее количество страниц]
from themes t, books b
where t.id = b.ThemeId 
group by t.Name
having avg(b.Pages) <= 400

--Показать сумму страниц по каждой тематике, учитывая только книги с количеством страниц более 400, и чтобы тематики были «Программирование», «Администрирование» и «Дизайн».
select t.Name,b.Pages
from themes t, books b
where t.id = b.ThemeId and b.Pages > 400 and t.Name like 'Программирование' or t.Name like 'Администрирование' or t.Name like 'Дизайн' 

select t.Name,sum(b.Pages)
from themes t, books b
where t.id = b.ThemeId and b.Pages > 400 and t.Name like 'Программирование' or t.Name like 'Администрирование' or t.Name like 'Дизайн' 
group by t.Name

--Показать информацию о работе магазинов: что, где, кем, когда и в каком количестве было продано.
select b.Name,c.Name,s.Name,sa.SaleDate, sa.Quantity
from books b 
join sales sa on sa.Bookid = b.Id
join shops s on sa.Shopid = s.id
join countries c on s.CountryId = c.id

--Показать самый прибыльный магазин.
select s.Name, sa.Quantity *sa.Price as pribl
from sales sa, shops s
where sa.Shopid = s.id

select s.Name, sum(sa.Quantity *sa.Price) as pribl
from sales sa, shops s
where sa.Shopid = s.id
group by s.Name
order by pribl desc

select t1.Name
from (select s.Name, sum(sa.Quantity *sa.Price) as pribl
from sales sa, shops s
where sa.Shopid = s.id
group by s.Name) t1,
(select max(t1.pribl) as maximus from (select s.Name, sum(sa.Quantity *sa.Price) as pribl
from sales sa, shops s
where sa.Shopid = s.id
group by s.Name) t1) t2
where t1.pribl = t2.maximus



