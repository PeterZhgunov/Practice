def banc():
  stavka = 10
  rub = int(input('Сумма вклада: '))
  years = int(input('Срок вклада: '))
  for i in range(years):
      summa = int(rub+stavka*rub/100)
      print(f'Ваша сумма вклада на срок {years} лет составит {summa} рублей')
      return summa
banc()
   
   

  