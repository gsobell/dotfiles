# packlist

Listing of user installed packages. Naming convention is `$HOSTNAME` for for progressively tracked list.

Not to be confused with `paclist`. [Paclist](https://aur.archlinux.org/packages/paclist/) prints a list categorized by repository, as opposed to whether the package was explicitly installed by the user.

Example packlist usage is as follows:

```bash
pacman -Qet -q > "Packages-$(date +%F).txt"
```
Example paclist usage is as follows:
```bash
paclist community | awk '{print $1}'
```
To be used to restore a snapshot of installed packages, and with [deployrable](https://github.com/gsobell/deployrable).
