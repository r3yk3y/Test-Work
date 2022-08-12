select product.id_product, product.Name_product
from product, (select id_product, count(*) as requests_count from request where YEAR(created_at) = YEAR(curdate()) group by id_product order by requests_count DESC limit 1) as request
where product.id_product = request.id_product;