# Используем официальный Node.js образ как базовый
FROM node:14

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json в рабочую директорию
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем все остальные файлы в рабочую директорию
COPY . .

# Собираем приложение
RUN npm run build

# Используем другой официальный образ для запуска веб-сервера
FROM nginx:alpine

# Копируем собранное приложение из предыдущего этапа в директорию для статических файлов nginx
COPY --from=0 /app/build /usr/share/nginx/html

# Экспонируем порт 80
EXPOSE 80

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]