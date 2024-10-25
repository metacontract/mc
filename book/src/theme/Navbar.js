import OriginalNavbar from "@theme-original/Navbar";
import React, { useEffect } from "react";

export default function Navbar(props) {
	useEffect(() => {
		const addClickListeners = (elements) => {
			for (const item of elements) {
				item.addEventListener("click", handleClick);
			}
		};

		const handleClick = (event) => {
			console.log("Link clicked:", event.target);

			const target = event.target;
			const liElement = target.closest("li.theme-doc-sidebar-item-category");
			if (liElement) {
				liElement.classList.toggle("menu__list-item--collapsed");

				const siblingUl = liElement.querySelector("ul");
				if (siblingUl) {
					siblingUl.style.display =
						siblingUl.style.display === "none" ? "block" : "none";
				}
			}
		};

		const sidebarItems = Array.from(
			document.querySelectorAll("a.menu__link--sublist"),
		);
		addClickListeners(sidebarItems);

		// Identify the boundary between link and category
		const listItems = document.querySelectorAll(
			"ul.theme-doc-sidebar-menu > li",
		);
		let lastLinkItem = null;
		for (const item of listItems) {
			if (item.classList.contains("theme-doc-sidebar-item-link")) {
				lastLinkItem = item;
			} else if (item.classList.contains("theme-doc-sidebar-item-category")) {
				if (lastLinkItem) {
					lastLinkItem.classList.add("last-link-before-category");
					lastLinkItem = null; // Reset after adding class
				}
			}
		}

		const observer = new MutationObserver((mutations) => {
			for (const mutation of mutations) {
				if (mutation.type === "childList") {
					const newItems = Array.from(
						document.querySelectorAll("a.menu__link--sublist"),
					);
					addClickListeners(newItems);
				}
			}
		});
		observer.observe(document.body, {
			childList: true,
			subtree: true,
		});

		// Cleanup function to remove event listeners
		return () => {
			for (const item of sidebarItems) {
				item.removeEventListener("click", handleClick);
			}
			observer.disconnect();
		};
	}, []);

	return <OriginalNavbar {...props} />;
}
