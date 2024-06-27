# Função para copiar arquivos JAR de módulos para o Docker
copy_jars_to_docker() {
  # Obter o nome do container Docker
  container_name="container-name"

  # Verificar se o container Docker está em execução
  if ! docker ps | grep -q "$container_name"; then
    echo "Erro: Container Docker '$container_name' não está em execução."
    return 1
  fi

  # Diretório raiz dos módulos
  modules_dir="$PWD/modules"

  # Loop para cada módulo
  for module_dir in "$modules_dir"/*; do
    # Verificar se o diretório do módulo existe
    if [ ! -d "$module_dir" ]; then
      continue
    fi

    # Nome do módulo
    module_name=$(basename "$module_dir")

    # Encontrar todos os arquivos JAR no diretório do módulo
    jar_files=$(find "$module_dir" -type f -name "*.jar")

    # Copiar cada arquivo JAR para o container Docker
    for jar_file in $jar_files; do
      jar_file_name=$(basename "$jar_file")
      docker cp "$jar_file" "$container_name:/opt/path"
      echo "Copiado $jar_file para $container_name:/app/$module_name/$jar_file_name"
    done
  done
}

# Função para usar o script
use_copy_jars_to_docker() {
  echo "Uso:"
  echo "copy_jars_to_docker <nome_do_container>"
  echo "Exemplo:"
  echo "copy_jars_to_docker my-app-container"
}

# Adicionar alias para o script
alias copy_jars_to_docker="copy_jars_to_docker"