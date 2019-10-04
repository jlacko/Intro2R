-- !preview conn=con


select
   *
from
   potraviny
where 1=1
   and obdobiod between date '2017-12-01' and date '2018-12-31'
limit 15
