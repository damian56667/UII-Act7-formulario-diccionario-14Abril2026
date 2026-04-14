import 'dart:io';

void main() async {
  print('\n========================================================');
  print(' 🤖 Agente de Repositorio GitHub (Plataforma Antigravity)');
  print('========================================================\n');

  // 1. Verificamos si git está inicializado, de lo contrario lo inicializamos
  var gitStatus = await Process.run('git', ['status']);
  if (gitStatus.exitCode != 0) {
    print('📂 Inicializando nuevo repositorio de Git...');
    await Process.run('git', ['init']);
  }

  // 2. Pedir link de la cuenta de GitHub
  stdout.write('🔗 Ingresa el link de tu repositorio en GitHub \n   (ej. https://github.com/usuario/repo.git): ');
  String? repoLink = stdin.readLineSync();
  
  if (repoLink == null || repoLink.trim().isEmpty) {
    print('\n❌ Error: Debes ingresar un enlace válido para continuar.');
    return;
  }

  // Verificar si ya existe un "remote origin", para actualizarlo o agregarlo
  var remoteCheck = await Process.run('git', ['remote', 'get-url', 'origin']);
  if (remoteCheck.exitCode == 0) {
    await Process.run('git', ['remote', 'set-url', 'origin', repoLink.trim()]);
    print('🔄 Remote "origin" actualizado exitosamente.');
  } else {
    await Process.run('git', ['remote', 'add', 'origin', repoLink.trim()]);
    print('✅ Remote "origin" agregado exitosamente.');
  }

  // 3. Establecer rama por defecto y preguntar por el cambio
  String branch = 'main';
  
  stdout.write('\n🌱 La rama por defecto es "$branch". ¿Deseas enviarlo a otra rama distinta? (s/N): ');
  String? changeBranch = stdin.readLineSync();
  
  if (changeBranch != null && changeBranch.toLowerCase() == 's') {
    stdout.write('👉 Escribe el nombre de la nueva rama: ');
    String? newBranch = stdin.readLineSync();
    if (newBranch != null && newBranch.trim().isNotEmpty) {
      branch = newBranch.trim();
    }
  }

  // Forzar la creación/nomenclatura de la rama seleccionada
  await Process.run('git', ['branch', '-M', branch]);
  print('✅ Trabajando sobre la rama: $branch');

  // 4. Agregar todos los cambios al staging area
  print('\n📦 Preparando los archivos para el commit...');
  await Process.run('git', ['add', '.']);

  // 5. Preguntar el mensaje del commit
  stdout.write('📝 Ingresa el mensaje del commit para esta actualización: ');
  String? commitMessage = stdin.readLineSync();
  
  if (commitMessage == null || commitMessage.trim().isEmpty) {
    commitMessage = 'Commit automático por Agente Antigravity';
  }

  print('⏳ Realizando commit...');
  var commitRes = await Process.run('git', ['commit', '-m', commitMessage]);
  // Es posible que exitCode sea 1 si no hay cambios para hacer commit.
  if (commitRes.exitCode == 0) {
    print('✅ Commit realizado: "$commitMessage"');
  } else if (commitRes.stdout.toString().contains('nothing to commit')) {
    print('⚠️ No se detectaron cambios nuevos para hacer commit. Intentaremos hacer Push de todos modos.');
  } else {
    print('⚠️ Ocurrió algo inesperado durante el commit:');
    print(commitRes.stdout);
  }

  // 6. Hacer el push al repositorio remoto
  print('\n🚀 Subiendo el código a GitHub...');
  var pushRes = await Process.run('git', ['push', '-u', 'origin', branch]);
  
  if (pushRes.exitCode == 0) {
    print('\n🎉 ¡Misión cumplida! Tu código fue subido exitosamente a GitHub.');
  } else {
    print('\n❌ Hubo un error al intentar subir el código:');
    print(pushRes.stderr);
    print('👉 Sugerencia: Revisa tu conexión, tus permisos (Tokens de acceso a Github) o si la rama remota tiene conflictos.');
  }

  print('\n========================================================\n');
}
