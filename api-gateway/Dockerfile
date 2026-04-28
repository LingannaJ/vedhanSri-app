FROM nginx:alpine
# Default config ని డిలీట్ చేసి మన config ని కాపీ చేస్తున్నాం
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]