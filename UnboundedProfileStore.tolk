tolk 1.1

struct Profile {
    username: string;
    bio: string;
    updated: uint32;
}

struct Storage {
    profiles: map<address, Profile>;
    totalProfiles: uint32;
    description: string;
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

fun updateProfile(name: string, bio: string) {
    var st = Storage.load();
    let caller = get_caller();

    if (!st.profiles.get(caller).isFound) {
        st.totalProfiles += 1;
    }

    st.profiles.set(caller, Profile{
        username: name,
        bio: bio,
        updated: blockchain.now()
    });

    st.description = "Profile store contract storing each user's profile in a map, causing linear storage growth.";
    st.save();
}
