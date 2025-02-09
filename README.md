# ansible-image
## Описание
Образ содержит ansible и утилиты.  
Файл [inventory.yaml](https://github.com/FZEN475/ansible-image/blob/main/inventory.yaml) вшит в образ.  
Путь к [inventory.json](https://github.com/FZEN475/ansible-image/blob/8f868df6b7ede27289ac161cea250ae7be57f9a2/docker-compose.yml#L8) вшит через аргументы сборки.  
Общие [библиотеки](https://github.com/FZEN475/ansible-library.git) обновляются при каждом запуске контейнера.  
Образ размещается локально и дальнейшие плейбуки выполняются с этим образом.  

## Подготовка
### Требования
| Soft   | Comment                                                         |
|:-------|:----------------------------------------------------------------|
| docker | Локальный или удалённый сервер для сборки и запуска контейнера. | 

| Дополнительно                 | Значение                                    | Comment                                                            |
|:------------------------------|:--------------------------------------------|:-------------------------------------------------------------------|
| SSH-key "безопасного" сервера | id_ed25519                                  | Нужно поместить в контейнер как секрет                             |
| inventory.json                | 192.168.2.1:/mnt/nas/secrets/inventory.json | По этому пути должен лежать inventory.json полученный из terraform |

## Установка
Запустить docker-compose.yml

### Дополнительно



### Ошибки

<!DOCTYPE html>
<table>
  <thead>
    <tr>
      <th>Проблема</th>
      <th>Решение</th>
    </tr>
  </thead>
  <tr>
      <td>Из контейнера не определяется DNS имя без домена.</td>
      <td>
На хосте докера:  
/etc/docker/daemon.json

```json
{
  "insecure-registries":["192.168.2.10:5000"],
  "dns": ["192.168.2.1","8.8.8.8"]
}
```
</td>
  </tr>
  <tr>
  </tr>
</table>
