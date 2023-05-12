# Environment
dev=true

# this.source
git_host="github.com"
namespace="Unicorn-OS"
package="Snapcraft"
module=$package
ansible_role=$module

clone(){
	# Either for Development or read-only
	if [ $dev ]; then
		url="git@"${git_host}":"${namespace}/${package}".git"
	else
		url="https://"${git_host}/${namespace}/${package}".git"
	fi
	# Remove empty package
	rmdir $package
	if [ ! -d "${package}" ]; then 
		git clone $url
	fi
}

link_dependency(){
	dir=".dependency"
	ansible_dir="ansible/roles/.dependency"
	cd ..
	mkdir -p $ansible_dir
	ln -srf $dir/$module/ansible/roles/$ansible_role ansible/roles/.dependency/
	cd -
}

ignore(){
	echo "$package" >.gitignore
}

main(){
	clone
	link_dependency
	ignore
}

main
