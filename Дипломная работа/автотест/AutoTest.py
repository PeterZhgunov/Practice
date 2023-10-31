import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
import pytest

browser = webdriver.Chrome()


def test_personalArea():
    browser.get("https://www.exist.ru/")

    Entrance = browser.find_element(By.ID, "pnlLogin").click()
    browser.implicitly_wait(3)
    Login = browser.find_element(By.NAME, "login")
    Login.send_keys('9041628299')
    Password = browser.find_element(By.NAME, "pass")
    Password.send_keys('ocabPWu')
    time.sleep(2)
    Button = browser.find_element(By.ID, "btnLogin").click()
    examination = browser.find_element(By.XPATH, '/html/body/div[1]/header/section[1]/div/div[3]/div/div[1]/span').text
    assert examination == '9041628299'
    if examination == '9041628299':
        print('Вход в личный кабинет')
    else:
        print('Вход в личный кабинет не выполнен')

def test_garage():
    b1 = browser.find_element(By.ID, 'pnlLogin').click()
    garag1 = browser.find_element(By.XPATH, '/html/body/div/header/section[1]/div/div[3]/div/div[2]/div/div/div/ul/li[1]/a').click()
    time.sleep(2)
    choiseCar = browser.find_element(By.CLASS_NAME, 'cell').click()
    time.sleep(2)
    CarInfo = browser.find_element(By.ID, "carTitle")
    if CarInfo.text == 'Volkswagen Tiguan 1.4 TSI':
       print('В гараже выбрали машину - Volkswagen Tiguan ')
    else:
       print('Наш гараж пуст')
    time.sleep(2)

def test_item_to_cart():
    catalog = browser.find_element(By.XPATH, '/html/body/div[1]/div/div[1]/form/div[4]/div[3]/div[3]/div[1]/ul/li[3]/a').click()
    time.sleep(2)
    catalog1 = browser.find_element(By.XPATH, '//*[@id="form1"]/div[4]/div[3]/div/div[1]/div[1]/div[2]/a').click()
    catalog2 = browser.find_element(By.XPATH, '/html/body/div[1]/div/div[1]/form/div[4]/div[3]/div[3]/div[2]/div[2]/div/div[1]/div[2]/a').click()
    time.sleep(1)
    basket = browser.find_element(By.XPATH, '/html/body/div[1]/header/section[2]/div[3]/noindex[2]/a').click()
    product = browser.find_element(By.CLASS_NAME, 'prc-table__description')
    if product.text == 'Диск тормозной, задний':
        print('Диск тормозной, задний успешно добавлен в корзину')
    else:
        print('Корзина пуста')

    time.sleep(5)

def test_item_remove():
    elementDel = browser.find_element(By.ID, 'slbDelete').click()
    infoBascet = browser.find_element(By.XPATH, '/html/body/div[1]/div/div[1]/form/div[3]/div[3]/h2')
    if infoBascet.text == 'В вашей корзине пусто!':
        print('Корзина очищена успешно')
    else:
        print('В корзине находится товар')
    time.sleep(3)

if __name__ == "__main__":
    pytest.main()

