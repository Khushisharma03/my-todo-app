# Use official Nginx image
FROM nginx:alpine

# Copy custom static website files into nginx's public directory
COPY public/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
