# ansible-image11
## Описание
* Сборка образа выполняется в github ci и помещается в registry.
* Для загрузки playbook.yaml требуется указать environment.ANSIBLE_REPO.
* Образ зависим от файлов inventory.json и inventory.yaml, которые копируются из "безопасного" расположения.
  * Файлы создаются при выполнении [terraform](https://github.com/FZEN475/terraform).
  * Путь для скачивания указывается через environment.INVENTORY и environment.STRUCTURE.
* Образ содержит ansible и утилиты.   
* Общие [библиотеки](https://github.com/FZEN475/ansible-library.git) 
  * Загружаются в /source/library при каждом создании контейнера.
  * Репозиторий библиотек environment.LIBRARY.

## Подготовка
### Требования
| Soft   | Comment                                                         |
|:-------|:----------------------------------------------------------------|
| docker | Локальный или удалённый сервер для сборки и запуска контейнера. | 

| Дополнительно             | Значение | Comment                                              |
|:--------------------------|:---------|:-----------------------------------------------------|
| environment.ANSIBLE_REPO  | git url  | Репозиторий с playbook.yaml                          |
| environment.SECURE_SERVER | IP/DNS   | IP или DNS сервера с inventory.json и structure.yaml |
| environment.INVENTORY     | path     | Расположение inventory.json на "безопасном" сервере  |
| environment.STRUCTURE     | path     | Расположение structure.yaml на "безопасном" сервере  |
| environment.LIBRARY       | git url  | Репозиторий с библиотеками ansible                   |

## Установка

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
  "dns": ["192.168.2.1","8.8.8.8"]
}
```
</td>
  </tr>
  <tr>
  </tr>
</table>
