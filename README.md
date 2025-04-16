# Squad Dedicated Server Installer - Windows

Este projeto fornece um script automatizado para baixar, instalar e configurar um servidor dedicado do jogo [Squad](https://joinsquad.com/) no Windows 11/10, com opção de escolha do disco de instalação e zero intervenção manual.

---

## 📁 Arquivos

- `instalar_squad_server.bat` → Script principal que executa todas as etapas da instalação.
- (Opcional) `README.md` → Este guia de instruções.

---

## ⚙️ O que o script faz?

- Baixa e instala automaticamente:
  - Visual C++ Redistributable 2013 e 2015
  - DirectX Runtime (Jun/2010)
  - SteamCMD
- Atualiza e instala o servidor do Squad usando SteamCMD.
- Cria o script `start_server.bat` para iniciar o servidor.
- Solicita ao usuário a letra do disco de instalação.
- Faz limpeza dos arquivos temporários ao final.

---

## 🚀 Como usar

### 1. Faça o download

Baixe o arquivo `install_squad_server.bat`.

### 2. Execute como Administrador

- Clique com o botão direito em `install_squad_server.bat` e selecione **Executar como Administrador**.
- O script solicitará que você informe a letra do disco de instalação (exemplo: `D`).

### 3. Aguarde a instalação

- O script fará todo o processo automaticamente.
- Ao final, será gerado o arquivo `start_server.bat` dentro da pasta `squad_server` no disco selecionado.

---

## 🛡️ Requisitos

- Windows 10 ou 11 (64 bits)
- Conexão com a Internet
- Permissões de Administrador

---

## 📡 Portas necessárias (abrir no firewall e roteador)

- **UDP 7787, 7788**
- **UDP/TCP 15000**
- **UDP/TCP 27165, 27166**
- **UDP/TCP 21114**

---

## 🕹️ Iniciando o servidor

Após a instalação:

1. Acesse a pasta:  
   `X:\squad_server\SquadGame\Binaries\Win64\`
2. Execute:  
   `start_server.bat`

---

## ❗ Problemas comuns

### “Este aplicativo não pode ser executado em seu PC”
- Verifique se você está executando o `.bat` corretamente com permissão de Administrador.
- Certifique-se de que o arquivo `.bat` foi salvo corretamente como UTF-8 e não está corrompido.
- Evite rodar o script em discos externos ou protegidos por políticas.

---

## ✉️ Suporte

Para dúvidas ou melhorias, abra um **issue** ou entre em contato com o autor do script.

---

## 📄 Licença

Este script é de uso livre e comunitário. Sinta-se à vontade para adaptá-lo.
