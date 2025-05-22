# bw-cli debian package

`bw` is a command-line interface tool for interacting with [Bitwarden](https://bitwarden.com/), a secure password manager.

## Features

- Securely access and manage your Bitwarden vault from the terminal
- Add, edit, and delete items
- Search and view vault entries
- Supports login, logout, and session management

## Installation

```bash
    
sudo apt install lsb-release wget apt-transport-https bzip2

wget -qO- https://repo.vitexsoftware.com/keyring.gpg | sudo tee /etc/apt/trusted.gpg.d/vitexsoftware.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/vitexsoftware.gpg]  https://repo.vitexsoftware.com  $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/vitexsoftware.list
sudo apt update

sudo apt install bw-cli
```

## Usage

```bash
bw [command] [options]
```

### Common Commands

- `login` — Authenticate with your Bitwarden account
- `logout` — End your session
- `list` — List all vault items
- `get <item>` — Retrieve a specific item
- `add` — Add a new item

## Configuration

Configure your environment variables or use a config file as needed for authentication.

## Building

```bash
git clone https://github.com/VitexSoftware/bw-cli.git
cd bw-cli
debuild -us -uc
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests on [GitHub](https://github.com/VitexSoftware/bw-cli).

## License

This project is licensed under the MIT License.
