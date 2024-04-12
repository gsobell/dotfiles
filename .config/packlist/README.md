# packlist

Listing of explicitly installed packages.

Running `packlist` performs the following.
```sh
pacman -Qqe > $HOSTNAME.txt
```

To restore or populate a new device:

```sh
yay -S --needed - < $HOSTNAME$.txt
```

See more [here.](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages)



