FROM nginx:1.12-alpine
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
